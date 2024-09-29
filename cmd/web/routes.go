package main

import (
	"net/http"

	"github.com/mahesh-singh/snippetbox/ui"
)

func (app *application) routes() http.Handler {
	mux := http.NewServeMux()

	mux.Handle("GET /static/", http.FileServerFS(ui.Files))

	mux.HandleFunc("GET /ping", ping)

	//TODO: why /{$}
	mux.HandleFunc("GET /{$}", app.home)

	mux.HandleFunc("GET /about", app.about)

	//TODO: in /snippet/view/{id} - valid and invalid wildcard
	mux.HandleFunc("GET /snippet/view/{id}", app.snippetView)
	mux.HandleFunc("GET /snippet/create", app.snippetCreate)
	mux.HandleFunc("POST /snippet/create", app.snippetCreatePost)

	mux.HandleFunc("GET /user/signup", app.userSignUp)
	mux.HandleFunc("POST /user/signup", app.userSignUpPost)
	mux.HandleFunc("GET /user/login", app.userLogin)
	mux.HandleFunc("POST /user/login", app.userLoginPost)
	mux.HandleFunc("GET /account/password/update", app.accountPasswordUpdate)
	mux.HandleFunc("POST /account/password/update", app.accountPasswordUpdatePost)
	mux.HandleFunc("POST /user/logout", app.userLogoutPost)

	return app.recoverPanic(app.logRequest(commonHeader(mux)))
}
