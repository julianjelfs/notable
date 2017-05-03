require('./main.css');
var logoPath = require('./logo.svg');
var Elm = require('./Main.elm');

var root = document.getElementById('root');

Elm.Main.embed(root);


/*
Going to probably need to store progress. Perhaps would be nice to store some general stats as well.
Or might be best to just store an event stream so that we can draw different conclusions later.

{
    a : { wrong: 10, right: 10 },
    b : { wrong: 10, right: 10 },
    c : { wrong: 10, right: 10 }
}
 */
