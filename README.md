makeitpersonal
===

This is an experiment in music sharing.

Lyric Sharing
----
[It looks like this](http://makeitpersonal.co/febuiles/two-suns-in-the-sunset). Sign up and start sharing!

Lyric Fetching Service
----
You can fetch lyrics from the website using a simple GET request to
`http://makeitpersonal.co/lyrics`. It expects two parameters, `artist` (artist name) and `title`
(song title). Try it out in the command line:

    curl -s "http://makeitpersonal.co/lyrics?artist=Protest%20the%20Hero&title=Tandem"

If you want full instructions on how to create a script to automate this task or if you want to
integrate this into your editor, check out [these instructions](https://gist.github.com/1549991).

Bugs
----
Plese file bugs and requests in the [issue tracker](https://github.com/febuiles/makeitpersonal/issues).
