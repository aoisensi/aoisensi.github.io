package main

import (
	"fmt"
	"image/color"
	"image/png"
	"net/http"
)

const url = "https://github.com/aoisensi/aoisensi/blob/master/aoisensi32px.png?raw=true"

const (
	zero = "０"
	four = "４"
)

var red = color.RGBA{255, 0, 0, 255}

func main() {
	r, err := http.Get(url)
	if err != nil {
		panic(err)
	}
	defer r.Body.Close()
	img, err := png.Decode(r.Body)
	size := img.Bounds().Size()
	for y := 0; y < size.Y; y++ {
		fmt.Print("<p>")
		co := color.RGBA{}
		for x := 0; x < size.X; x++ {
			cl := img.At(x, y)
			r, g, b, _ := cl.RGBA()
			c := color.RGBA{byte(r), byte(g), byte(b), 255}

			if c != co && x != 0 {
				fmt.Print("</span>")
			}

			if c != co && x != size.X-1 {
				fmt.Printf("<span style=\"color: #%02x%02x%02x;\">", c.R, c.G, c.B)
			}

			str := zero
			if c == red {
				str = four
			}
			fmt.Print(str)

			co = c
		}
		fmt.Println("</span></p>")
	}
}
