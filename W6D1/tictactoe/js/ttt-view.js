class View {
  constructor(game, $el) {
    this.game = game;
    this.$el = $el.append(this.setupBoard());

  }

  bindEvents() {

  }

  makeMove($square) {
    // check if the game is over and flash message
    let pos = $square.data("position"); // [i,j]
    let mark = this.game.currentPlayer;
    let squareMark = $("<h2>");
    squareMark.text(`${mark}`).css("font-size", 100).css("text-align", "center");
    $square.append(squareMark);
    $square.data("mark", mark);
    this.game.playMove(pos);
    if (this.game.isOver()){
      let winnerText = $("<p>");
      winnerText.text(`You win, ${mark}!`);
      this.$el.append(winnerText);
      this.endGame(mark);
    }
  }

  endGame(winnerMark) {
    console.log($('li'));
    $('li').each (function(li) {
      const $li = $(this);
      if ($li.data("mark") === winnerMark) {
        $li.css("background-color", "green");
      } else if ($li.attr("class") === "marked") {
        $li.css("background-color", "red");
      } else {
        $li.css("background-color", "white");
        $li.unbind("mouseenter mouseleave");
      }
    });
  }

  setupBoard() {
    let ulOuter = $("<ul></ul>");
      for (let i = 0; i < 3; i++) {
      let ulInner = $("<ul></ul>");
      for (let j = 0; j < 3; j++) {
        let li = $("<li></li>");
        li.css("float", "left").addClass("square");
        li.css("background-color", "gray");
        li.hover(el => {
            let currentTarget = el.currentTarget;
            const $currentTarget = $(currentTarget);
            $currentTarget.css("background-color", "yellow");
          },el => {
              let currentTarget = el.currentTarget;
              const $currentTarget = $(currentTarget);
              $currentTarget.css("background-color", "gray");
            });

        li.data("position", [i, j]);

        li.click((el)=> {
          let currentTarget = el.currentTarget;
          const $currentTarget = $(currentTarget);
          if  ($currentTarget.attr("class") === "marked") {
            alert("invalid move");
          }else{
            $currentTarget.unbind("mouseenter mouseleave");
            $currentTarget.css("background-color", "white");
            $currentTarget.removeClass("square");
            $currentTarget.addClass("marked");
            this.makeMove(li);
          }
        });
        ulInner.append(li);
      }
      ulInner.addClass("group");
      ulOuter.append(ulInner.append($("<br>").append($("<br>"))));
    }
    return ulOuter;
  }
}

module.exports = View;
