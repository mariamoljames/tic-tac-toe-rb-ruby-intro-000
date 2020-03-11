







def position_taken?(board,index)
  @board[index]="X"||@board[index]="O"
end

def valid_move?(board,index)
  if index.between?(0,8) && !(position_taken?(board,index))
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input=gets.chomp
  index=input_to_index(input)
  if valid_move?(board,index)
    display_board(board)
    current_player=current_player(board)
    move(board,index,current_player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count=0
  board.each do |index|
    if index=="X"||index=="O"
      count+=1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board)%2==0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  if !board.none? { |item| item=="X"||item=="O" }
    WIN_COMBINATIONS.each do |win_combination|
      if [board[win_combination[0]],board[win_combination[1]],board[win_combination[2]]].all?{ |item| item=="X"||item=="O" } && board[win_combination[0]]==board[win_combination[1]] && board[win_combination[1]]==board[win_combination[2]]
        return win_combination
      end
    end
    return false
  end
end

def full?(board)
  return board.all? { |item| item=="X"||item=="O" }
end

def draw?(board)
  return full?(board) && !won?(board)
end

def over?(board)
  return draw?(board) || won?(board)
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  else
    return nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
