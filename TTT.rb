#Benjamin Stewart 8/24/2015
#Tac Toe Submission for Flatiron School Technical Interview

class Board

  def initialize
    @board = Array.new(3) { Array.new(3, " ") }  #initialized empty board filled with 9 spaces
  end

  def printInstructions                         #game introduction, rules, and instructions. 
    puts "Welcome to Ben's world famous Tic Tac Toe Game",
    
    "\nThe object of Tic Tac Toe is to get three in",
    "a row. You play on a three by three game board.",
    "The first player is known as X and the second",
    "is O. Players alternate placing Xs and Os on",
    "the game board until either oppent has three",
    "in a row or all nine squares are filled.",
    "\n"

    puts "        1 | 2 | 3",
         "        ---------",
         "        4 | 5 | 6",
         "        ---------",
         "        7 | 8 | 9"
    print "\n"
  end

  def printBoard                               #creates board to be looped/updated during game
    (0..2).each do |row|                       #format will match the board printed from the instructions
      print "       "
      (0..2).each do |col|
        print @board[row][col]
        print " | " unless col == 2
      end
      print "\n"
      print "       ---------\n" unless row == 2
    end
    print "\n"
  end

  def findWinner 
    #  X X X        X
    #          &    X
    #               X

    (0..2).each do |i|
      if @board[i][0] == @board[i][1] && @board[i][1] == @board[i][2]
        return @board[i][0] unless @board[i][0] == " "

      elsif @board[0][i] == @board[1][i] && @board[1][i] == @board[2][i]
        return @board[0][i] unless @board[0][i] == " "
      end
    end

    #  X               X
    #    X     &     X
    #      X       X

    if ( @board[0][0] == @board[1][1] && @board[1][1] == @board[2][2] ) ||
       ( @board[0][2] == @board[1][1] && @board[1][1] == @board[2][0] )
      return @board[1][1] unless @board[1][1] == " "
    end

    #  X O X
    #  X O X
    #  O X O

    return "C" unless @board.join.split('').include?(" ")

    # Undecided/ Game still in progress

    return "U"
  end

  def dropPiece(piece, row, col)
    @board[row][col] = piece if (0..2) === row &&
                                (0..2) === col &&
                                @board[row][col] == " "
  end
end

board = Board.new
active_player = "X"                             #start with X user

puts "\n" * 100                                 #spacing to eliminate previous game boards from view
board.printInstructions                         #let the games begin

while board.findWinner == "U"                   #while loop for gameplay

  puts " #{active_player}'s turn. Choose a box!",
       "        **----**"
  print "           "
  move = gets.chomp.to_i - 1                    
  row = move / 3
  col = move % 3

  puts "\n" * 100        

  if board.dropPiece(active_player, row, col)   #Take turns
    if active_player == "X"
      active_player = "O"
    else
      active_player = "X"
    end
  else
    puts "                 Invalid move, please select again\n\n" #prevent any duplicates or other invalid moves
  end

  board.printBoard
end

winner = board.findWinner

puts "\n" * 100
puts "   ================="

  if winner == "C"                              #if game is a draw
    puts "     IT IS A DRAW!"                    
  else
    puts "     #{winner} ' S   W I N"           #string will display winner
  end

puts "   ================="
puts "\n"
board.printBoard
puts "\n        ======="