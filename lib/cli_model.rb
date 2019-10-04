class CommandLineInterface
  def initialize

  end

  def greet
    puts "Welcome to Gamerstop, the best platform for gamers and games!"
    puts "Want to buy games but don't know where to look? Gamerstop is the place!"
    puts "Are you a new user or a do you already have a gamer id with us? new/returning"
    new_or_returning = gets.chomp

    if new_or_returning == "new"
      show_options1
    elsif new_or_returning == "returning"
      @have_not_ran_loop = false
      show_options2
    end
  end

  def show_options1 #Greet the user and get their gamer tag
    puts "Option 1: Create a gamer tag to access all options in the store"
    puts "Option 2: Look at all the available games"
    puts "Option 3: Buy a game and add it into your library of games. You can only buy one game when you're a new user."
    puts "Option 4: Refund a game"
    puts "Option 5: Exit"
    puts "Just type 1 - 5 for the option you're interested in to get started"
    response = gets.chomp

    if response == "1"
      #Run the method, create
      option1_create
    elsif response == "2"
      #Run the method, read
      option2_read
    elsif response == "3"
      #Run the method, update
      option3_update
    elsif response == "4"
      #Run the method, delete
      option4_delete
    elsif response == "5"

    end
  end
end

def option1_create
  puts "We're going to create your unique gamer id. It's very simple. Just choose a number between 1 - 10"
  response = gets.chomp

  if response != nil
    @find_gamer_tag = Gamer.find_by(id: response)
    @new_gamer = Gameplatform.create(gamer_id: @find_gamer_tag.id, game_id: 0)

    puts "Your gamer id is #{@find_gamer_tag.id}."
    puts "Your username for the gamer id is #{@find_gamer_tag.username}"
  end

  puts "Now that you have your gamer id, you can start exploring the different options we have in store."
  puts "When you're ready, type ready into the chat and it'll take you back into the options menu."

  create_ready = gets.chomp
  if create_ready == "ready"
    show_options1
  end
end

def option2_read

  puts "Are you interested in seeing what we have in store? Yes/No"
  response_to_above = gets.chomp

  if response_to_above == "Yes"
    @available_games = Game.all.map { |key|
    key.name
  }
  end
    puts @available_games
    puts "Above is all the games we have at the moment. Take your time to look at what you want."
    puts "When you're ready, just type ready into the chat and it'll take you back into the options menu so you can buy the game"
    ready_input = gets.chomp

    if ready_input == "ready"
      show_options1
    end
end

def option3_update
  @games_owned_by_gamer = 0
  @available_games = Game.all.map { |key| key.name }
  puts @available_games
  puts "Again, this is the list of games. If you're interested in one, just simply type the name of the game."

  response_to_game = gets.chomp
  @game_name = Game.find_by(name: response_to_game)
  puts "We have #{@game_name.name} for #{@game_name.cost} dollars."
  puts "Do you want to buy this game? Yes/No"
  buy_this_game_response = gets.chomp
  if buy_this_game_response == "Yes"
    @new_gamer.update(gamer_id: @find_gamer_tag.id, game_id: @game_name.id)
    puts "You have bought #{@game_name.name} for #{@game_name.cost} dollars."
    @games_owned_by_gamer += 1
    delete_a_game = Game.find_by(id: @game_name.id)
    delete_a_game.delete
    update_gamer = Gamer.find_by(id: @find_gamer_tag.id)
    update_gamer.update(username: @find_gamer_tag.username, games_owned: @games_owned_by_gamer)
    puts "This is your gamer tag: #{@find_gamer_tag.id}, and #{@game_name.name} is the game you currently own."
  elsif buy_this_game_response == "No"
    option3_update
  end
  puts "Would you like to go back to the options menu or just exit the store. back/exit"
  back_or_exit = gets.chomp
  if back_or_exit == "back"
    show_options1
  elsif back_or_exit == "exit"
    puts "Thank you for shopping at Gamerstop. The place for all gamers."
  end
end

def option4_delete
  puts "What is your gamer id and what game do you want to refund?"
  puts "Gamer ID:"
  gamer_id_response = gets.chomp
  puts "Game Name:"
  game_name_response = gets.chomp
  puts "Identifying gamer..."
  if game_name_response != nil
    create_new_game = Game.create(name: game_name_response, cost: 10)
  end

  game_id = Game.find_by(name: game_name_response).id
  gamer_id = Gamer.find_by(id: gamer_id_response).id
  returning_user = Gameplatform.find_by(gamer_id: gamer_id)

  if returning_user != nil
    puts "We found you on our records. Do you want to refund this game still? Yes/No"
    yes_or_no = gets.chomp
  end

    if yes_or_no == "Yes"
      returning_user.delete
      puts "You have refunded your game. Your ID that was tied with the game was also removed."
      @games_owned_by_gamer -= 1
      delete_a_game = Gamer.find_by(id: @find_gamer_tag.id)
      delete_a_game.update(username: @find_gamer_tag.username, games_owned: @games_owned_by_gamer)
      puts "Your receipt: Gamer ID: #{gamer_id_response}, Game Name: #{game_name_response} refunded."

      show_options1
    end
  end

def show_options2
  if @have_not_ran_loop == false
    @has_already_used_option_menu = false
    @have_not_ran_loop = true
  end
  if @has_already_used_option_menu == false
    @has_already_used_option_menu = true
  puts "Welcome back gamer!"
  puts "What is your gamer id?"
  gamer_id_response = gets.chomp
  @id_gamer = Gameplatform.find_by(gamer_id: gamer_id_response)
end
  p @id_gamer
  puts "What would you like to do today?"
  puts "Option 1: Checkout a new game"
  puts "Option 2: View the available games in your library"
  puts "Option 3: Refund a game"
  puts "Option 4: Delete your account"
  puts "Option 5: Exit"

  options = gets.chomp

  if options == "1"
    return1
  elsif options == "2"
    return2
  elsif options == "3"
    return3
  elsif options == "4"
    return4
  elsif options == "5"

  end
end

def return1
  puts "These are the available games."
  available_games = Game.all.map { |key|
    key.name
  }
  puts available_games
  puts "Take your time. When you're ready, just type the name of the game you're interested in to get started."
  game_response = gets.chomp
  @name_of_game = Game.all.find_by(name: game_response)
  puts "We have #{@name_of_game.name} for #{@name_of_game.cost} dollars."
  puts "Do you want to buy this game?"
  yes_or_no = gets.chomp

  if yes_or_no == "Yes"
    puts "You have bought #{@name_of_game.name} for #{@name_of_game.cost} dollars."

    new_game_bought = Gameplatform.create(gamer_id: @id_gamer.gamer_id, game_id: @name_of_game.id)
    puts "Are you still interested in buying another game?"
    another_game = gets.chomp

    if another_game == "Yes"
      return1
    elsif another_game == "No"
      puts "We're going to take you back to the options menu now."
      @has_already_used_option_menu = true
      show_options2
    end
  elsif yes_or_no == "No"
    puts "Would you like to look at another game? Yes/No"
    another_game_response = gets.chomp

    if another_game_response == "Yes"
      return1
    elsif another_game_response  == "No"
      puts "Thank you for shopping with us."
    end
  end
end

def return2
  puts "These are all the games you currently own."
  all_games = Gameplatform.all.select { |key|
    key.gamer_id == @id_gamer.gamer_id
  }
  get_games_from_id = all_games.map { |key|
    key.game_id
  }
  see_if_condition_met = Game.all.select { |key|
    key.id
  }
  id_of_games = see_if_condition_met.map { |key|
    key.id
  }
  name_of_games = see_if_condition_met.map { |key|
    key.name
  }







end

def return3
  puts "What game did you want to refund?"

end

def return4

end
