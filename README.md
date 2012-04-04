makeitpersonal
===

This is an experiment in music sharing and loving.

Lyric Fetching Service
----
You can fetch lyrics from the website using a simple GET request to
`http://makeitpersonal.co/lyrics`. It expects two parameters, `artist` (artist name) and `title`
(song title). Try it out in the command line:

    curl -s "http://makeitpersonal.co/lyrics?artist=Protest%20the%20Hero&title=Tandem"

If you want full instructions on how to create a script to automate this task or if you want to
integrate this into your editor, check out [these instructions](https://gist.github.com/1549991).

Lyric Sharing
----
I'm testing a lyric sharing service too, [it looks like
this](http://makeitpersonal.co/user_lyrics/1). If you want to try it out just send me a tweet
[@febuiles](http://twitter.com/febuiles) or drop me a line at [federico@mheroin.com](mailto:federico@mheroin.com)

Bugs
----
Both services are pretty buggy right now, if you have any problems please file a bug in the [issue tracker](https://github.com/febuiles/makeitpersonal/issues).
