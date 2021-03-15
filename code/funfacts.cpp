// funfacts
// Picks from a random list of fun facts.
// Developed by Brett. (https://github.com/notronaldmcdonald)


// header

#include <iostream>
#include <cstdlib>
#include <ctime>
#include <string.h>
#include <fstream>
using namespace std;

int main() {
  // define variables
  string name;
  string viewfact;
  string factcool;
  string newfact;
  int frederick = 6;
  int rchoice;
  // generate the random choice here
  srand (time(NULL));
  const string fact1 = "Did you know that water isn't actually wet?";
  const string fact2 = "Did you know that the odds of dying at least once in your life are greater than 95 percent?";
  const string fact3 = "Did you know that entering the letter 'b' in the field below does something cool if you have a specific name?";
  const string fact4 = "Did you know that the average speed of a Brett on a bike is roughly 10km/h?";
  const string fact5 = "Did you that there are only five fun facts? Try and get them all!";
  // debug switch - displays the rchoice variable value at every generation
  int enable_debug = 0;
  // code starts here
  cout << "\nWelcome to Fun Facts!";
  cout << "\n\nPlease enter your name: ";
  cin >> name;
  cout << "\nSo, " << name << ", would you like to hear a Fun Fact?";
  cout << "\n(Enter 'yes' or 'no')\n";
  cin >> viewfact;
  if (viewfact == "yes") {
    cout << "\nOkay!";
    while (frederick == 6) {
      cout << "\nPicking a fun fact...";
      rchoice = rand() % 5 + 1;
      if (enable_debug == 1) {
        cout << "\ndebug: rchoice == " << rchoice;
      }
      else {
        cout << "\n";
      }
      cout << "\nFun fact selected.";
      if (rchoice == 1) {
        cout << "\n" << fact1;
      }
      else if (rchoice == 2) {
        cout << "\n" << fact2;
      }
      else if (rchoice == 3) {
        cout << "\n" << fact3;
      }
      else if (rchoice == 4) {
        cout << "\n" << fact4;
      }
      else if (rchoice == 5) {
        cout << "\n" << fact5;
      }
      else {
        cout << "\nSomehow generated a number outside of the range, contact the creator for assistance.";
        return 1;
      }
      cout << "\nSo, " << name << ", was that a fun fact or what?";
      cout << "\nEnter a response (yes or no): ";
      cin >> factcool;
      if (factcool == "yes") {
        cout << "\nExactly.";
      }
      else if (factcool == "no") {
        cout << "\nYou're a real bitch, you know that?";
      }
      else if ( (factcool == "b") && (name == "Lindsay") || (name == "lindsay") ) {
        cout << "\nThat's an invalid response. You absolute baffoon. Exiting...";
        cout << "\n\n\n\n\n\n\n\n\n\n\n\n\n\n...is what I'd normally say.";
        cout << "\n\nYou triggered the secret, " << name << ".";
        cout << "\n\n\nSo, I just wanted to wish you a happy birthday.";
        cout << "\nI'd have gotten you something, but I genuinely have no idea what you'd want.";
        cout << "\nHave a nice day, " << name << "!";
        cout <<"\n\n- Brett";
        break;
      }
      else {
        cout << "\nThat's an invalid response. You absolute baffoon. Exiting...";
        break;
      }
      cout << "\nWant to see another fun fact?";
      cout << "\nEnter yes or no: ";
      cin >> newfact;
      cout << "\nEvaluating response...";
      if (newfact == "yes") {
        cout << "\nOkay! Looping...";
      }
      else if (newfact == "no") {
        cout << "\nOkay. I'll just exit then...";
        break;
      }
      else {
        cout << "\nRead the instructions you dumbass. Exiting...";
        break;
      }
    }
    return 0;
  }
}
