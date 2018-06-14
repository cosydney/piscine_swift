let card1 : Card = Card(c: Color.Spade, v: Value.Ace)
let card2 : Card = Card(c: Color.Diamond, v: Value.Two)
let card3 : Card = Card(c: Color.Spade, v: Value.Ace)
let card4 : Card = Card(c: Color.Spade, v: Value.Jack)

print ("card1:", card1)
print ("card2:", card2)
print ("card3:", card3)
print ("card4:", card4)

print("\n Testing isEqual")
print("card1.isEqual(card2) should evaluate to false:", card1.isEqual(card2))
print("card1.isEqual(card3) should evaluate to true:", card1.isEqual(card3))
print("card2.isEqual(card3) should evaluate to false:", card2.isEqual(card3))

print("\n Testing ==")
print("card1 == card2, should evaluate to false:", card1 == card2)
print("card1 == card3, should evaluate to true:", card1 == card3)
print("card2 == card3, should evaluate to false:", card2 == card3)
