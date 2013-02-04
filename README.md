Lamplighter is a slick open source Mac OS X application for presenting PDFs and songtexts on a projector or secondary screen. It does nothing else, but what it does it does better than any other tool I know for this task.

I still don't have all features in places I would like to see in this application, but I thought I'd rather publish a 90% ready application than nothing at all. If you're a developer, feel free to fork this thing and submit pull requests :)

### Download

* [Version 0.1.0](https://github.com/halo/Lamplighter/raw/0.1.0/latest_build/Lamplighter.zip) (Lion or higher)

### Screenshot

![screenshot](https://raw.github.com/halo/Lamplighter/master/doc/screenshot.png)

### Features

* Add PDFs to Lamplighter by dragging them into the PDF drawer. Present them by double-clicking on the page you would like to present.
* Add Songs by clicking on the add button in the Songs drawer.
* Import songs from Easislides by drag-and-dropping the Easislides exported XML file into the Songs drawer.
* Search for songs using the same technology as Spotlight. E.g. a search for "song this" will yield all songs which have "this" *and* "song" in their title or description. Dead simple and dead fast.
* Drag important songs or PDFs from the drawer into your "Playlist" for immediate access.
* When you have no second screen/projector attached, what you would see on the projector is shown in a preview window.

### Known bugs

* When you edit a song in the Drawer while it also is in your playlist, Lamplighter occasionaly crashes. CoreData is terribly hard to debug, I wish somebody could program Objective-C ;)

### Copyright

MIT 2013 funkensturm. See [MIT-LICENSE](http://github.com/halo/Lamplighter/blob/master/MIT-LICENSE).
