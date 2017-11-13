defmodule DeckTest do
  use ExUnit.Case
  doctest Deck

  test "deck contents" do
    deck = Deck.new_deck()
    
    assert 1 == Enum.count(deck, &(&1 == {"10", :spades}))
    assert 1 == Enum.count(deck, &(&1 == {"10", :clubs}))
    assert 1 == Enum.count(deck, &(&1 == {"10", :hearts}))
    assert 1 == Enum.count(deck, &(&1 == {"10", :diamonds}))
    
    assert 1 == Enum.count(deck, &(&1 == {"A", :spades}))
    assert 1 == Enum.count(deck, &(&1 == {"K", :spades}))
    assert 1 == Enum.count(deck, &(&1 == {"Q", :spades}))
    assert 1 == Enum.count(deck, &(&1 == {"J", :spades}))
  end
  
  test "deck face values" do
    deck = Deck.new_deck()
    cards = Enum.map(deck, fn {value, _suit} -> value end)
    
    values = ~w{2 3 4 5 6 7 8 9 10 J Q K A}
    assert true == check_deck_values(cards, values, 4)
  end
  
  test "deck suits" do
    deck = Deck.new_deck()
    cards = Enum.map(deck, fn {_value, suit} -> suit end)
    
    suits = [:spades, :clubs, :hearts, :diamonds]
    assert true == check_deck_values(cards, suits, 13)
  end
  
  test "shuffle deck" do
    deck = Deck.new_deck()
    deck_2 = Deck.shuffle(deck)
    
    assert deck != deck_2
  end
  
  test "draw card" do
    deck = Deck.new_deck()
    
    {card, deck} = Deck.draw(deck, 1)
    assert  1 == Enum.count(card)
    assert 51 == Enum.count(deck)
    
    {cards, deck} = Deck.draw(deck, 2)
    assert  2 == Enum.count(cards)
    assert 49 == Enum.count(deck)
  end
  
  test "cut deck" do
    deck = Deck.new_deck()
    cut_deck = Deck.cut(deck, 3)
    
    {top, bottom} = Deck.draw(deck, 3)
    my_cut_deck = Enum.concat(bottom, top)
    
    assert cut_deck == my_cut_deck
  end
  
  test "burn card" do
    deck = Deck.new_deck()
    burned = Deck.burn_card(deck)
    
    {_burn_card, my_burned} = Deck.draw(deck, 1)
    assert burned == my_burned
  end
  
  
  # === helper test functions ==================================================
  
  def check_deck_values(cards, values, occur) do
    check_deck_values(cards, values, occur, true)
  end
  
  def check_deck_values(_, [], _occur, result) do
    result
  end
  
  def check_deck_values(_, _, _occur, false) do
    false
  end
  
  def check_deck_values(cards, [this_value | rest], occur, true) do
    valid = (occur == Enum.count(cards, &(&1 == this_value)))
    check_deck_values(cards, rest, occur, valid)
  end
  
end
