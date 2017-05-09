require('./main.css');
var logoPath = require('./logo.svg');
var Elm = require('./Main.elm');

var root = document.getElementById('root');

const app = Elm.Main.embed(root);
let stats = JSON.parse(window.localStorage.getItem('note_stats')) || {};
app.ports.stats.send(percentage(stats));

function percentage(stats) {
    let rights = 0;
    let wrongs = 0;

    for(k in stats) {
        rights += stats[k].right;
        wrongs += stats[k].wrong;
    }

    return ((rights / (wrongs + rights)) * 100) || 0;
}

app.ports.answer.subscribe(function(answer) {
    if(stats[answer.note] == null) {
        stats[answer.note] = {
            right: 0,
            wrong: 0
        };
    }

    if(answer.correct) {
        stats[answer.note].right += 1;
    } else {
        stats[answer.note].wrong += 1;
    }

    window.localStorage.setItem('note_stats', JSON.stringify(stats));
    app.ports.stats.send(percentage(stats));
});
