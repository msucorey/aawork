const View = require('./ttt-view.js');
const Game = require('./../solution/game.js');

$( () => {
  const $el = $('.ttt');
  let game = new Game();
  let view = new View(game, $el);
});
