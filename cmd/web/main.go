package main

import (
	"log"
	"net/http"
)

func main() {
	mux := http.NewServeMux()

	fileServer := http.FileServer(http.Dir("./ui/static"))

	mux.Handle("GET /static/", http.StripPrefix("/static", fileServer))

	//TODO: why /{$}
	mux.HandleFunc("GET /{$}", home)
	//TODO: in /snippet/view/{id} - valid and invalid wildcard
	mux.HandleFunc("GET /snippet/view/{id}", snippetView)
	mux.HandleFunc("GET /snippet/create", snippetCreate)
	mux.HandleFunc("POST /snippet/create", snippetCreatePost)

	log.Print("starting a server on : 4000")

	err := http.ListenAndServe(":4000", mux)
	log.Fatal(err)
}
