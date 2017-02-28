/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	const HanoiGame = __webpack_require__(1);
	const HanoiView = __webpack_require__(2);

	$( () => {
	  const rootEl = $('.hanoi');
	  const game = new HanoiGame();
	  new HanoiView(game, rootEl);
	});


/***/ },
/* 1 */
/***/ function(module, exports) {

	class Game {
	  constructor() {
	    this.towers = [[3, 2, 1], [], []];
	  }

	  isValidMove(startTowerIdx, endTowerIdx) {
	      const startTower = this.towers[startTowerIdx];
	      const endTower = this.towers[endTowerIdx];

	      if (startTower.length === 0) {
	        return false;
	      } else if (endTower.length == 0) {
	        return true;
	      } else {
	        const topStartDisc = startTower[startTower.length - 1];
	        const topEndDisc = endTower[endTower.length - 1];
	        return topStartDisc < topEndDisc;
	      }
	  }

	  isWon() {
	      // move all the discs to the last or second tower
	      return (this.towers[2].length == 3) || (this.towers[1].length == 3);
	  }

	  move(startTowerIdx, endTowerIdx) {
	      if (this.isValidMove(startTowerIdx, endTowerIdx)) {
	        this.towers[endTowerIdx].push(this.towers[startTowerIdx].pop());
	        return true;
	      } else {
	        return false;
	      }
	  }

	  print() {
	      console.log(JSON.stringify(this.towers));
	  }

	  promptMove(reader, callback) {
	      this.print();
	      reader.question("Enter a starting tower: ", start => {
	        const startTowerIdx = parseInt(start);
	        reader.question("Enter an ending tower: ", end => {
	          const endTowerIdx = parseInt(end);
	          callback(startTowerIdx, endTowerIdx)
	        });
	      });
	  }

	  run(reader, gameCompletionCallback) {
	      this.promptMove(reader, (startTowerIdx, endTowerIdx) => {
	        if (!this.move(startTowerIdx, endTowerIdx)) {
	          console.log("Invalid move!");
	        }

	        if (!this.isWon()) {
	          // Continue to play!
	          this.run(reader, gameCompletionCallback);
	        } else {
	          this.print();
	          console.log("You win!");
	          gameCompletionCallback();
	        }
	      });
	  }
	}

	module.exports = Game;


/***/ },
/* 2 */
/***/ function(module, exports) {

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


/***/ }
/******/ ]);