package main

import (
	"crypto/tls"
	"database/sql"
	"flag"
	"html/template"
	"log/slog"
	"net/http"
	"os"
	"time"

	"github.com/mahesh-singh/snippetbox/internal/models"

	_ "github.com/jackc/pgx/v5/stdlib"
)

type application struct {
	logger        *slog.Logger
	snippets      *models.SnippetModel
	users         *models.UserModel
	templateCache map[string]*template.Template
}

func main() {

	//Define the flag
	addr := flag.String("addr", ":4000", "HTTP Network address")

	dsn := flag.String("dsn", "host=localhost user=web password=pass dbname=snippetbox sslmode=disable", "Postgres data source name ")
	//parse the flag. Need to call before flags get used
	flag.Parse()

	logger := slog.New(slog.NewTextHandler(os.Stdout, nil))

	db, err := openDB(*dsn)
	if err != nil {
		logger.Error(err.Error())
		os.Exit(1)
	}

	defer db.Close()

	templateCache, err := newTemplateCache()

	if err != nil {
		logger.Error(err.Error())
		os.Exit(1)
	}

	app := application{
		logger:        logger,
		snippets:      &models.SnippetModel{DB: db},
		users:         &models.UserModel{DB: db},
		templateCache: templateCache}

	tlsConfig := &tls.Config{
		CurvePreferences: []tls.CurveID{tls.X25519, tls.CurveP256},
	}

	srv := &http.Server{
		Addr:         *addr,
		Handler:      app.routes(),
		ErrorLog:     slog.NewLogLogger(logger.Handler(), slog.LevelError),
		TLSConfig:    tlsConfig,
		IdleTimeout:  time.Minute,
		ReadTimeout:  5 * time.Second,
		WriteTimeout: 10 * time.Second,
	}

	logger.Info("starting server", slog.Any("addr", *addr))

	err = srv.ListenAndServeTLS("./tls/cert.pem", "./tls/key.pem")
	logger.Error(err.Error())
	os.Exit(1)
}

func openDB(dns string) (*sql.DB, error) {

	db, err := sql.Open("pgx", dns)

	db.Ping()
	if err != nil {
		db.Close()
		return nil, err
	}
	return db, nil
}
