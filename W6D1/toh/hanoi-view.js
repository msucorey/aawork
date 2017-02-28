class HanoiView {
  constructor(game , $rootEl) {
    this.game = game;
    this.$rootEl = $rootEl.append(this.setupTowers());
    this.render(this.game.towers);
    this.clickTower();
    this.firstClick = null;
  }

  clickTower(){
    this.resetTowers();
    $('.group').each ((idx, ul)=>{
        ul.click( () => {
          if (this.firstClick) {
            this.move(this.firstClick, ul.data("stackID"));
          } else {
            this.firstClick = ul.data("stackID");
            ul.css("border-bottom", "thick solid blue");
          }
        });
    });
  }

  move(fromTower, toTower) {
    if (fromTower === toTower) {
      alert("invalid move");
    } else {
      if (this.game.move(fromTower, toTower)) {
        this.render(this.game.towers);
      } else {
        alert("invalid move");
      }
    }
    this.reset();
  }

  reset() {
    this.firstClick = null;
    $('.group').each ((idx, ul)=>{
        ul.css("border-bottom", "thick solid black");
    });
  }

  setupTowers (){
    let outerUL = $("<ul>");
    for (let i = 0; i < 3; i++) {
      let innerUL = $("<ul>");
      innerUL.addClass("group");
      innerUL.data("stackID", i);
      innerUL.hover(el => {
            let currentTarget = el.currentTarget;
            const $currentTarget = $(currentTarget);
            $currentTarget.css("border-bottom", "thick solid red");
          },el => {
              let currentTarget = el.currentTarget;
              const $currentTarget = $(currentTarget);
              $currentTarget.css("border-bottom", "thick solid black");
            });
      for (let j = 0; j < 3; j++) {
        let li = $("<li>");
          li.data("pos", [i,j]);
        if (i === 0) {
          switch (j) {
            case 0:
            li.addClass("large");
              break;
            case 1:
            li.addClass("medium");
              break;
            default:
            li.addClass("small");
          }
        } else {
          li.addClass("empty");
        }
        innerUL.append(li);
      }
      outerUL.append(innerUL);
    }
    return outerUL;
  }

  render(towerArrays){
    this.resetTowers();
    $('li').each ((idx, li)=>{
      let pos = li.data("pos");
      switch (towerArrays[pos[0]][pos[1]]) {
        case 3:
        li.addClass("large");
        break;
        case 2:
        li.addClass("medium");
        break;
        case 1:
        li.addClass("small");
          break;
        default:
        li.addClass("empty");
        }
    });


  }

  resetTowers() {
    $("li").each ((idx, li) => {
      let thisClass = li.attr("class");
      li.removeClass(thisClass);
    });
  }
}

module.exports = HanoiView;
