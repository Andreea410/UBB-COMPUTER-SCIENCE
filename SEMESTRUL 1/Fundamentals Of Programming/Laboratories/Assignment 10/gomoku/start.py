from gomoku.UI.ui import UserInterface
from gomoku.UI.gui import GraphicalUserInterface

if __name__ == '__main__':
    ui = UserInterface()
    option = input("UI or GUI? ")
    if option.lower() == "ui":
        ui.play()
    elif option.lower() == "gui":
        gui = GraphicalUserInterface()
        gui.start_window()
    else:
        print("Invalid option")