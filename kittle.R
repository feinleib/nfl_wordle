# Kittle: NFL Wordle
# By Max Feinleib, 2022
# Inspired by Wordle (Josh Wardle), Poeltl (Gabe Danon), and MLB Pickle (Jeremy Frank and Zach Ellis)

# packages
library(dplyr)
library(stringr)
library(readr)

# loading team sheets, answers, colleges
import_data <- function() {
  BAL <<- read_csv("2021 sheets/BAL.csv")
  BUF <<- read_csv("2021 sheets/BUF.csv")
  CHI <<- read_csv("2021 sheets/CHI.csv")
  CIN <<- read_csv("2021 sheets/CIN.csv")
  CLE <<- read_csv("2021 sheets/CLE.csv")
  DEN <<- read_csv("2021 sheets/DEN.csv")
  GB <<- read_csv("2021 sheets/GB.csv")
  LAR <<- read_csv("2021 sheets/LAR.csv")
  LV <<- read_csv("2021 sheets/LV.csv")
  PHI <<- read_csv("2021 sheets/PHI.csv")
  TB <<- read_csv("2021 sheets/TB.csv")
  LAC <<- read_csv("2021 sheets/LAC.csv")
  DAL <<- read_csv("2021 sheets/DAL.csv")
  SF <<- read_csv("2021 sheets/SF.csv")
  NE <<- read_csv("2021 sheets/NE.csv")
  PIT <<- read_csv("2021 sheets/PIT.csv")
  WAS <<- read_csv("2021 sheets/WAS.csv")
  KC <<- read_csv("2021 sheets/KC.csv")
  TEN <<- read_csv("2021 sheets/TEN.csv")
  NO <<- read_csv("2021 sheets/NO.csv")
  IND <<- read_csv("2021 sheets/IND.csv")
  MIN <<- read_csv("2021 sheets/MIN.csv")
  ARI <<- read_csv("2021 sheets/ARI.csv")
  HOU <<- read_csv("2021 sheets/HOU.csv")
  DET <<- read_csv("2021 sheets/DET.csv")
  ATL <<- read_csv("2021 sheets/ATL.csv")
  SEA <<- read_csv("2021 sheets/SEA.csv")
  MIA <<- read_csv("2021 sheets/MIA.csv")
  JAX <<- read_csv("2021 sheets/JAX.csv")
  NYG <<- read_csv("2021 sheets/NYG.csv")
  NYJ <<- read_csv("2021 sheets/NYJ.csv")
  CAR <<- read_csv("2021 sheets/CAR.csv")
  answers <<- read_csv("answers.csv")
  colleges <<- read_csv("colleges.csv") %>% select(-comments)
  
  # 1538 players
  all_players <<- bind_rows(ARI, ATL, BAL, BUF, CAR, CHI, CIN, CLE, 
                           DAL, DEN, DET, GB, HOU, IND, JAX, KC, 
                           LAC, LAR, LV, MIA, MIN, NE, NO, NYG, 
                           NYJ, PHI, PIT, SEA, SF, TB, TEN, WAS)
  
  team_sheets <<- list(ARI, ATL, BAL, BUF, CAR, CHI, CIN, CLE, 
                      DAL, DEN, DET, GB, HOU, IND, JAX, KC, 
                      LAC, LAR, LV, MIA, MIN, NE, NO, NYG, 
                      NYJ, PHI, PIT, SEA, SF, TB, TEN, WAS)
  names(team_sheets) <<- sapply(team_sheets, function(x) x$team[1])
  
  # square emoji macros
  green_square <<- "\U1F7E9"
  black_square <<- "\U2B1B"
  yellow_square <<- "\U1F7E8"
  
  rm(ARI, ATL, BAL, BUF, CAR, CHI, CIN, CLE, 
     DAL, DEN, DET, GB, HOU, IND, JAX, KC, 
     LAC, LAR, LV, MIA, MIN, NE, NO, NYG, 
     NYJ, PHI, PIT, SEA, SF, TB, TEN, WAS,
     envir = globalenv())
}

import_data()

####################################################
### To play, just enter `play()` in the console. ###
####################################################
play <- function() {
  player_num <- sample(1:nrow(answers), 1)
  correct_player <<- get_row(answers$player_name[player_num])
  
  cat("* * * * * * * * [ KITTLE: NFL Wordle ] * * * * * * * *\n\n")
  game_over <- FALSE
  num_guesses <- 0
  while (game_over == FALSE) {
    num_guesses <- num_guesses + 1
    cat("Guess a player name, or type \"quit\" to quit (Guess #", num_guesses, "):",
        sep = "")
    guess_name <- scan("", 
                       what = character(),
                       nlines = 1,
                       sep = "\n",
                       quiet = TRUE)
    
    guess_output <- guess(guess_name)
    print(guess(guess_name)[c(-9, -10)])
    # don't charge guess for invalid name
    if (is.character(guess_output)) {
      num_guesses <- num_guesses - 1
      # type "quit" to quit game
      if (guess_output == "quit") {
        cat("Game over...", "\n",
            "Number of guesses: ", num_guesses, "\n",
            "Correct player: ", "\n",
            sep = "")
        print(correct_player)
        game_over <- TRUE
      }
    } else if (guess_output[10] == correct_player[10]) {
      cat("You win!", "\n", "Number of guesses: ", num_guesses, "\n",
          sep = "")
      game_over <- TRUE
    }
  }
}


###
### Gameplay helpers
###

# Wordle output
guess <- function(name) {
  output <- get_row(name)
  if (nrow(output) == 0) {
    if (name == "quit") {
      return("quit")
    }
    return(paste("Player [", name, "] not found", sep = ""))
  } else if (nrow(output) > 1) {
    teams <- output$team
    cat("Which one? Select the team (choices:", teams, ")", sep = " ")
    guess_team <- scan("", 
                       what = character(),
                       nlines = 1,
                       sep = "\n",
                       quiet = TRUE)
    if (guess_team %in% teams) {
      output <- output %>% filter(team == guess_team)
    } else {
      cat("Invalid team selection...\n")
      guess(name)
    }
  }
  output <- output %>% 
    check_team() %>% check_pos() %>% 
    check_nums() %>% check_college()
  return(output)
}

# find player row
get_row <- function(name) {
  output <- all_players %>% 
    filter(player_name == name) %>% 
    select(player_name, team, conf, div, Pos, No., Yrs, 
           College, ncaa_conf, player_id)
  return(output)
}

###
### matching to correct player
###

# check match for team, conf, div
check_team <- function(guess_player) {
  for (i in c(2,3,4)) {
    square <- if_else(guess_player[i] == correct_player[i], 
                      green_square, black_square)
    
    guess_player[i] <- paste(guess_player[i], square)
  }
  return(guess_player)
}

# check match for position
check_pos <- function(guess_player) {
  square <- case_when(guess_player[5] == correct_player[5] ~ green_square,
                      get_pos_group(guess_player[5]) == 
                        get_pos_group(correct_player[5]) ~ yellow_square,
                      TRUE ~ black_square)
  
  guess_player[5] <- paste(guess_player[5], square)
  return(guess_player)
}
create_pos_groups <- function() {
  off_skill <<- c("QB", "RB", "HB", "FB", "WR", "TE", "WR/RB")
  off_line <<- c("C", "G", "T", "OG", "OT", "OL", "LG", "RG", "LT", "RT")
  def_line <<- c("DT", "DE", "EDGE", "DL", "NT")
  def_lbs <<- c("LB", "MLB", "OLB", "ILB", "LILB", "RILB", "LOLB", "ROLB")
  def_backs <<- c("CB", "DB", "S", "FS", "SS")
  spec_teams <<- c("K", "P", "PK", "LS", "KR", "PR")
  pos_groups <<- list(off_skill, off_line, def_line, def_lbs, def_backs, spec_teams)
  names(pos_groups) <<- c("off_skill", "off_line", "def_line", "def_lbs", "def_backs", "spec_teams")
  rm(off_skill, off_line, def_line, def_lbs, def_backs, spec_teams, envir = globalenv())
  return()
}
get_pos_group <- function(Pos) {
  pos_group = case_when(Pos %in% pos_groups$off_skill ~ "off_skill",
                        Pos %in% pos_groups$off_line ~ "off_line",
                        Pos %in% pos_groups$def_line ~ "def_line",
                        Pos %in% pos_groups$def_lbs ~ "def_lbs",
                        Pos %in% pos_groups$def_backs ~ "def_backs",
                        Pos %in% pos_groups$spec_teams ~ "spec_teams")
  return(pos_group)
}

# check match for No., Yrs experience
check_nums <- function(guess_player) {
  for (i in c(6, 7)) {
    square <- case_when(guess_player[i] == correct_player[i] ~ green_square,
                        abs(guess_player[i] - correct_player[i]) <= 2 ~ yellow_square,
                        TRUE ~ black_square)
    
    guess_player[i] <- paste(guess_player[i], square)
  }
  return(guess_player)
}

# check match for college
check_college <- function(guess_player) {
  square <- case_when(guess_player[8] == correct_player[8] ~ green_square,
                      guess_player[9] == correct_player[9] ~ yellow_square,
                      TRUE ~ black_square)
  guess_player[8] <- paste(guess_player[8], square)
  return(guess_player)
}

play()
