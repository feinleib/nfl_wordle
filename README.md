# Kittle: NFL Wordle

## *WELCOME TO THE LEAGUE:* About *Kittle*

Welcome to *Kittle: NFL Wordle*! *Kittle* is a textual Wordle-style game, and it is written and played in R.

I wrote this game in the fall of 2021, and it is inspired by the original [Wordle](https://www.nytimes.com/games/wordle/index.html) game by Josh Wardle, along with prior sports spin-offs [Poeltl](https://poeltl.dunk.town) by Gabe Danon and [MLB Pickle](https://mlbpickle.com) (originally titled WARdle) by Jeremy Frank and Zach Ellis. I created this game before the publication of the popular NFL Wordle game [Weddle](https://www.weddlegame.com), and I took no inspiration from Weddle.

NFL fans will recognize that the game is named after San Francisco tight end George Kittle.

## *TRAINING CAMP:* Downloading *Kittle*

Follow these directions to download and set up everything you'll need to get started with playing *Kittle.*

1. If you don't have one already, download an IDE that supports R, such as [RStudio](https://www.rstudio.com/products/rstudio/download/).
2. Click on the latest [Release](https://github.com/feinleib/nfl_wordle/releases) on the right side of this page, and download the files `kittle.R` and `2021.sheets.zip`.
   i. **IMPORTANT:** Make sure those two files are in the same folder on your computer! Otherwise the game won't work.
3. Unzip the `2021.sheets.zip` file, making sure that the new `2021 sheets` folder stays inside the same folder as `kittle.R`.
4. Open `kittle.R` (**TIP:** if you've used R before, do it in a new RStudio project).
5. Highlight all the text in the `kittle.R` file (Command-A on Mac, Ctrl-A on Windows), and run all the code (Command-Enter on Mac, Ctrl-Enter on Windows). This will create all the dataframes and functions you need to play the game.
6. Click inside the Console box on the bottom to move your cursor there.
7. Type in any NFL player's name to get started!

## *GAMEDAY:* Playing *Kittle*

After you finish the steps in the previous section, you'll have started your first game of Kittle.

* Guess a player by typing their full name.
   - You can guess any player who started one game in the 2021 NFL season, or the leading kicker or punter on each team.
   - **TIP:** The name must be complete, including capitalization and suffixes (e.g. "Tre'Davious White", "Odell Beckham Jr.", and "T.J. Watt"). If you get a "Player not found" message, no worries - it doesn't count as a guess. Just try a different spelling, or you can look it up in the `all_players` sheet.
   - **TIP:** If you guess a name that belongs to multiple NFL players (e.g. "Josh Allen"), you'll be asked to type in the abbreviation of the team of the player you mean to guess.

* After you guess, you will see 7 of the player's characteristics to help you find the right answer.
   - Team: <u>**GREEN**</u> means the right team, <u>**BLACK**</u> means the wrong team.
   - Conf: <u>**GREEN**</u> means the right conference, <u>**BLACK**</u> means the wrong conference.
   - Div: <u>**GREEN**</u> means the right division, <u>**YELLOW**</u> means the right conference, <u>**BLACK**</u> means the wrong conference.
   - Pos: <u>**GREEN**</u> means the right position, <u>**YELLOW**</u> means the right position group, <u>**BLACK**</u> means the wrong position group.
      - Position groups: Offensive skill (QB, RB, FB, WR, TE), Offensive line (C, G, T, OG, OT, OL, LG, RG, LT, RT), Defensive line (DT, DE, EDGE, DL, NT), Linebackers (LB, OLB, ILB, MLB, LOLB, ROLB, LILB, RILB), Defensive backs (CB, DB, S, FS, SS), Special teams (P, K)
      - The positions are from the team rosters on [Pro Football Reference](https://www.pro-football-reference.com). All the position variants are due to PFR's data. Sorry.
   - No.: <u>**GREEN**</u> means the right jersey number, <u>**YELLOW**</u> means within 2, <u>**BLACK**</u> means more than 2 away.
   - Yrs: <u>**GREEN**</u> means the right years of experience, <u>**YELLOW**</u> means within 2, <u>**BLACK**</u> means more than 2 away.
   - College: <u>**GREEN**</u> means the right college, <u>**YELLOW**</u> means the right college conference, <u>**BLACK**</u> means the wrong conference.
      - Conferences: [Power 5] ACC, Big 12, Big Ten, Pac-12, SEC; [Group of 5] American, C-USA, MAC, Mountain West, Sun Belt; Independent; [Non-FBS] FCS, D2, D3, NAIA, Canada, none

* You have unlimited guesses, and you can play as often as you want. Feel free to make your own rules for yourself.

* If you're stuck, you can guess `quit` to end the game and show the correct answer.
   - \*secret tip\*: Yes, you can look through the `answers` sheet as you play. You can decide for yourself if that's cheating...

### *THE PLAYBOOK:* Future plans

* I will work on updating the game with 2022 rosters after Pro Football Reference makes 2022 the current season.

* I'll clean up the position data in the 2022 version.

* I plan to make this a Shiny app so you can play on the web (this should fix the exact-spelling headaches).

Let me know any other ways you want to see me make *Kittle* better.

## Have fun!
