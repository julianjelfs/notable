require('./main.css');
var logoPath = require('./logo.svg');
const { Elm } = require('./Main.elm');

var root = document.getElementById('root');

function emptyStats() {
    return {
        octaves: [0,1,2,3,4,5].map(function(o) {
            return {
                octave: o,
                notes: ['C', 'D', 'E', 'F', 'G', 'A', 'B'].map(function (n) {
                    return {
                        note: n,
                        correct: 0,
                        incorrect: 0
                    };
                })
            };
        })
    }
}

const app = Elm.Main.init({
    node: root
});
var stats = JSON.parse(window.localStorage.getItem('note_stats')) || emptyStats();
if(!stats.octaves) {
    stats = emptyStats();
}
app.ports.receiveStats.send(stats);

function noteIndex(notes, note) {
    for(var i=0; i<notes.length; i++) {
        if(notes[i].note == note) {
            return i;
        }
    }
    return -1;
}

app.ports.answer.subscribe(function(answer) {
    console.log(answer);
    var index = noteIndex(stats.octaves[answer.octave].notes, answer.note);
    if(answer.correct) {
        stats.octaves[answer.octave].notes[index].correct += 1
    } else {
        stats.octaves[answer.octave].notes[index].incorrect += 1
    }

    window.localStorage.setItem('note_stats', JSON.stringify(stats));
    app.ports.receiveStats.send(stats);
});

