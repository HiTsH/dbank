import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Int "mo:base/Int";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank {
  //stable keyword converts variable to main the latest value not matter app refreshed or reopened
  // without it the variable returns to it's original value. (orthogonal persistance)

  stable var currentValue : Float = 300;

  // currentValue := 100;

  let id = 234632683264;

  //Debug.print(debug_show (id));

  stable var startTime = Time.now();
  startTime := Time.now();

  public func topUp(amount : Float) {
    currentValue += amount;

    Debug.print(debug_show (currentValue));
  };
  public func withdraw(amount : Float) {
    let tempValue : Float = currentValue - amount;
    if (tempValue >= 0) {
      currentValue -= amount;
      // Debug.print(debug_show (currentValue));
    } else {
      Debug.print("Error!: withdraw amount higher than balance!");
    };
  };

  // query method, require 'async' and 'type i.e. Nat/Int/...' and 'return'
  public query func checkBalance() : async Float {
    return currentValue;
  };

  public func compound() {
    let currentTime = Time.now();
    let timeElappsedNS = currentTime - startTime;
    let timeElappsed = timeElappsedNS / 1000000000;

    currentValue := currentValue * (1.01 ** Float.fromInt(timeElappsed));

    startTime := currentTime;
  }

  //topUp();
};
