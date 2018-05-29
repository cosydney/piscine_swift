let card1 : Card = Card(Color: Color.clubs, Value: Value.king)
let card2 : Card = Card(Color: Color.clubs, Value: Value.jack)
let card3 : Card = Card(Color: Color.clubs, Value: Value.king)

print ("card1:", card1)
print ("card2:", card2)
print ("card3:", card3)

print("\n Testing isEqual")
print(card1.isEqual(card2), "card1.isEqual(card2) should evaluate to false")
print(card1.isEqual(card3), "card1.isEqual(card3) should evaluate to true")
print(card2.isEqual(card3), "card2.isEqual(card3) should evaluate to false")

print("\n Testing ==")
print(card1 == card2, "card1 == card2, should evaluate to false")
print(card1 == card3, "card1 == card3, should evaluate to true")
print(card2 == card3, "card2 == card3, should evaluate to false")
