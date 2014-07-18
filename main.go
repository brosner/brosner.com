package main

import (
	"github.com/go-martini/martini"
	"github.com/martini-contrib/render"
	"io/ioutil"
	"log"
	"net/http"
	"os"
	"time"
)

type Application struct {
	Logger *log.Logger
}

func main() {
	m := martini.Classic()
	app := Application{
		log.New(os.Stdout, "[brosner] ", 0),
	}
	m.Use(render.Renderer(render.Options{
		Layout: "layout",
	}))
	m.Use(martini.Static("static/compiled", martini.StaticOptions{Prefix: "static"}))
	m.Map(app)
	m.Get("/", func(app Application, r render.Render) {
		r.HTML(200, "index", "hello world")
	})
	m.Get("/api/posts/", func(app Application, w http.ResponseWriter) {
		time.Sleep(5 * time.Second)
		w.Header().Set("Content-Type", "application/json; charset=utf-8")
		w.Write([]byte("[{\"id\": 1, \"a\": \"hello\"}]"))
	})
	m.Get("/.well-known/keybase.txt", func(app Application) (int, string) {
		data, err := ioutil.ReadFile("keybase.txt")
		if err != nil {
			app.Logger.Printf("%s", err)
			return 500, "error"
		}
		return 200, string(data)
	})
	m.Run()
}
