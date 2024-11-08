class Board
    attr_accessor :grid
  
    def initialize
      @grid = Array.new(3) { Array.new(3, " ") }
    end
  
    def display
      puts " #{@grid[0][0]} | #{@grid[0][1]} | #{@grid[0][2]} "
      puts "---+---+---"
      puts " #{@grid[1][0]} | #{@grid[1][1]} | #{@grid[1][2]} "
      puts "---+---+---"
      puts " #{@grid[2][0]} | #{@grid[2][1]} | #{@grid[2][2]} "
    end
  
    def update_board(row, col, symbol)
      if @grid[row][col] == " "
        @grid[row][col] = symbol
        true
      else
        false
      end
    end
  
    def full?
      @grid.all? { |row| row.none? { |cell| cell == " " } }
    end
  
    def winning_combination?(symbol)
      winning_positions = [
        [[0, 0], [0, 1], [0, 2]], # Row 1
        [[1, 0], [1, 1], [1, 2]], # Row 2
        [[2, 0], [2, 1], [2, 2]], # Row 3
        [[0, 0], [1, 0], [2, 0]], # Column 1
        [[0, 1], [1, 1], [2, 1]], # Column 2
        [[0, 2], [1, 2], [2, 2]], # Column 3
        [[0, 0], [1, 1], [2, 2]], # Diagonal 1
        [[0, 2], [1, 1], [2, 0]]  # Diagonal 2
      ]
  
      winning_positions.any? do |positions|
        positions.all? { |row, col| @grid[row][col] == symbol }
      end
    end
  end
  
  class Player
    attr_reader :name, :symbol
  
    def initialize(name, symbol)
      @name = name
      @symbol = symbol
    end
  end
  
  class Game
    def initialize
      @board = Board.new
      @player1 = Player.new("Player 1", "X")
      @player2 = Player.new("Player 2", "O")
      @current_player = @player1
    end
  
    def play
      loop do
        @board.display
        row, col = player_move
        if @board.update_board(row, col, @current_player.symbol)
          if @board.winning_combination?(@current_player.symbol)
            @board.display
            puts "#{@current_player.name} wins!"
            break
          elsif @board.full?
            @board.display
            puts "It's a tie!"
            break
          else
            switch_player
          end
        else
          puts "Invalid move! Try again."
        end
      end
    end
  
    private
  
    def player_move
      puts "#{@current_player.name}, enter your move (row and column) separated by a space:"
      gets.chomp.split.map { |n| n.to_i - 1 }
    end
  
    def switch_player
      @current_player = @current_player == @player1 ? @player2 : @player1
    end
  end
  
  # Para começar o jogo:
  Game.new.play
  