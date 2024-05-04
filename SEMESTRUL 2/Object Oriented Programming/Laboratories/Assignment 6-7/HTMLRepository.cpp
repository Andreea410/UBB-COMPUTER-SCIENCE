#include "HTMLRepository.h"
#include "RepositoryExceptions.h"

HTMLRepository::HTMLRepository(const std::string& filename) : Repository(filename) {
    this->file = filename;
}

void strip(std::string& string) {
    while (!string.empty() && (string.back() == ' ' || string.back() == '\t' || string.back() == '\n'))
        string.pop_back();
    reverse(string.begin(), string.end());
    while (!string.empty() && (string.back() == ' ' || string.back() == '\t' || string.back() == '\n'))
        string.pop_back();
    reverse(string.begin(), string.end());
}

void html_strip(std::string& string) {
    strip(string);
    string = string.substr(0, string.size() - 5);
    reverse(string.begin(), string.end());
    string = string.substr(0, string.size() - 4);
    reverse(string.begin(), string.end());
    strip(string);
}

void link_strip(std::string& string) {
    string = string.substr(0, string.size() - 4);
    reverse(string.begin(), string.end());
    string = string.substr(0, string.size() - 9);
    reverse(string.begin(), string.end());
    int length = (string.size() - 2) / 2;
    string = string.substr(0, string.size() - length - 2);
}

std::vector<Dog> HTMLRepository::loadFromFile() {
    std::ifstream file(this->file);

    if (!file.is_open()) {
        throw FileException("The file could not be opened!");
    }

    std::vector<Dog> new_list;
    std::string line;
    for (int i = 1; i <= 7; i++) {
        std::getline(file, line);
    }

    do {
        std::getline(file, line);
        strip(line);
        if (line != "<tr>")
            break;

        std::string breed, name, age, photograph, isAdopted;

        std::getline(file, breed);
        html_strip(breed);

        std::getline(file, name);
        html_strip(name);

        getline(file, age);
        html_strip(age);

        std::getline(file, photograph);
        html_strip(photograph);
        link_strip(photograph);

        getline(file, isAdopted);
        html_strip(isAdopted);

        std::getline(file, line);
        bool adopted;
        if(stoi(isAdopted) == 0)
            adopted = false;
        else
            adopted = true;
        new_list.push_back(Dog(breed,name,stoi(age),photograph,adopted));
    } while (true);

    file.close();
    return new_list;
}

void HTMLRepository::saveToFile() {
    std::ofstream file(this->file);

    if (!file.is_open()) {
        throw FileException("The file could not be opened!");
    }

    file << "<!DOCTYPE html>\n<html>\n<head>\n<title>Watchlist</title>\n</head>\n<body>\n<table border=1>\n";
    for (auto dog : this->dogs) {
        file << "<tr>\n" << "<td>" << dog.getBreed() << "</td>\n" << "<td>" << dog.getName() << "</td>\n"
            << "<td>" << to_string(dog.getAge()) << "</td>\n" << "<td><a href=\"" << dog.getPhotograph()<< "</a></td>\n" << "<td>" << to_string(dog.getIsAdopted()) << "</td>\n"<< "</tr>\n";
    }
    file << "</table>\n</body>\n</html>";
    file.close();
}

