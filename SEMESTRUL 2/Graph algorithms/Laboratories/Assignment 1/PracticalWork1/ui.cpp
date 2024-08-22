#include <iostream>
#include <stdexcept>
#include <random>
#include <unordered_map>
#include <vector>

using namespace std;

class FileRepository {
private:
    std::unordered_map<std::pair<int, int>, int> dictCost;
    std::unordered_map<int, std::vector<int>> dictOut;
    std::unordered_map<int, std::vector<int>> dictIn;

public:
    void add_edge(int start, int end, int cost) {
        dictCost[std::make_pair(start, end)] = cost;
        dictOut[start].push_back(end);
        dictIn[end].push_back(start);
    }

    void remove_edge(int start, int end) {
        dictCost.erase(std::make_pair(start, end));
        auto it = std::find(dictOut[start].begin(), dictOut[start].end(), end);
        if (it != dictOut[start].end())
            dictOut[start].erase(it);
        it = std::find(dictIn[end].begin(), dictIn[end].end(), start);
        if (it != dictIn[end].end())
            dictIn[end].erase(it);
    }

    void add_vertex(int id) {
        // If the vertex doesn't exist, add it
        if (dictOut.find(id) == dictOut.end()) {
            dictOut[id] = std::vector<int>();
            dictIn[id] = std::vector<int>();
        }
    }

    void remove_vertex(int id) {
        // Remove edges connected to this vertex
        for (auto it = dictOut[id].begin(); it != dictOut[id].end(); ++it) {
            int end = *it;
            dictCost.erase(std::make_pair(id, end));
            auto iter = std::find(dictIn[end].begin(), dictIn[end].end(), id);
            if (iter != dictIn[end].end())
                dictIn[end].erase(iter);
        }
        dictOut.erase(id);
        dictIn.erase(id);
    }

    void modify_cost(int start, int end, int new_cost) {
        dictCost[std::make_pair(start, end)] = new_cost;
    }

    int retrieve_cost(int start, int end) {
        return dictCost[std::make_pair(start, end)];
    }

    std::unordered_map<std::pair<int, int>, int> get_dictCost() {
        return dictCost;
    }

    std::unordered_map<int, std::vector<int>> get_dictOut() {
        return dictOut;
    }

    std::unordered_map<int, std::vector<int>> get_dictIn() {
        return dictIn;
    }

    int get_number_of_vertices() {
        return dictOut.size();
    }

    int get_number_of_edges() {
        return dictCost.size();
    }

    int get_out_degree(int vertex) {
        return dictOut[vertex].size();
    }

    int get_in_degree(int vertex) {
        return dictIn[vertex].size();
    }

    std::vector<int> parse_outbound_edges(int vertex) {
        return dictOut[vertex];
    }

    std::vector<int> parse_inbound_edges(int vertex) {
        return dictIn[vertex];
    }

    // Function to create a random graph (for demonstration purposes)
    static FileRepository create_random_graph() {
        FileRepository random_graph;
        std::random_device rd;
        std::mt19937 gen(rd());
        std::uniform_int_distribution<> vertex_dist(1, 10); // Random number of vertices
        std::uniform_int_distribution<> cost_dist(1, 100);  // Random cost

        int num_vertices = vertex_dist(gen);
        int num_edges = vertex_dist(gen) * 2;  // Assuming average of 2 edges per vertex

        for (int i = 0; i < num_edges; ++i) {
            int start = vertex_dist(gen);
            int end = vertex_dist(gen);
            int cost = cost_dist(gen);
            random_graph.add_edge(start, end, cost);
        }

        return random_graph;
    }
};

class UI {
private:
    FileRepository* _repository;

public:
    UI(FileRepository* file_repository) : _repository(file_repository) {}

    void print_menu() {
        std::cout << "Welcome to this graph application" << std::endl;
        std::cout << "1. See the graph you have" << std::endl;
        std::cout << "2. Add a new edge" << std::endl;
        std::cout << "3. Remove an existing edge" << std::endl;
        std::cout << "4. Add a new vertex" << std::endl;
        std::cout << "5. Remove an existing vertex" << std::endl;
        std::cout << "6. Modify the cost of an edge" << std::endl;
        std::cout << "7. Show number of vertices" << std::endl;
        std::cout << "8. Show number of edges" << std::endl;
        std::cout << "9. Create a random graph" << std::endl;
        std::cout << "10. Show the out degree of a vertex" << std::endl;
        std::cout << "11. Show the in degree of a vertex" << std::endl;
        std::cout << "12. Parse outbound edges of a vertex" << std::endl;
        std::cout << "13. Parse inbound edges of a vertex" << std::endl;
        std::cout << "14. Retrieve the cost of an edge" << std::endl;
        std::cout << "0. Exit" << std::endl;
    }

    void see_graph_you_have() {
        auto dictionary_of_costs = _repository->get_dictCost();
        auto number_of_vertices = _repository->get_number_of_vertices();
        auto number_of_edges = _repository->get_number_of_edges();
        std::cout << "We have " << number_of_vertices << " vertices and " << number_of_edges << " edges" << std::endl;
        for (const auto& key : dictionary_of_costs) {
            std::cout << "Edge starting from " << key.first.first << " ending in " << key.first.second
                << " with the cost " << key.second << std::endl;
        }

        auto dictionary_out = _repository->get_dictOut();
        auto dictionary_in = _repository->get_dictIn();
        for (const auto& key : dictionary_out) {
            if (dictionary_out[key.first].empty() && dictionary_in[key.first].empty()) {
                std::cout << "Empty node " << key.first << std::endl;
            }
        }
    }

    void add_edge() {
        try {
            int start, end, cost;
            std::cout << "Give starting point: ";
            std::cin >> start;
            std::cout << "Give end point: ";
            std::cin >> end;
            std::cout << "Give cost: ";
            std::cin >> cost;
            _repository->add_edge(start, end, cost);
        }
        catch (...) {
            std::cout << "Invalid input" << std::endl;
        }
    }

    void remove_edge() {
        try {
            int start, end;
            std::cout << "Give starting point: ";
            std::cin >> start;
            std::cout << "Give end point: ";
            std::cin >> end;
            _repository->remove_edge(start, end);
        }
        catch (...) {
            std::cout << "Invalid input" << std::endl;
        }
    }

    void add_vertex() {
        try {
            int id;
            std::cout << "Give vertex number: ";
            std::cin >> id;
            _repository->add_vertex(id);
        }
        catch (...) {
            std::cout << "Invalid input" << std::endl;
        }
    }

    void remove_vertex() {
        try {
            int id;
            std::cout << "Give vertex number: ";
            std::cin >> id;
            _repository->remove_vertex(id);
        }
        catch (...) {
            std::cout << "Invalid input" << std::endl;
        }
    }

    void modify_cost() {
        try {
            int start, end, new_cost;
            std::cout << "Give starting point: ";
            std::cin >> start;
            std::cout << "Give end point: ";
            std::cin >> end;
            std::cout << "Give new cost: ";
            std::cin >> new_cost;
            _repository->modify_cost(start, end, new_cost);
        }
        catch (...) {
            std::cout << "Invalid input" << std::endl;
        }
    }

    void retrieve_cost() {
        try {
            int start, end;
            std::cout << "Give starting point: ";
            std::cin >> start;
            std::cout << "Give end point: ";
            std::cin >> end;
            auto cost = _repository->retrieve_cost(start, end);
            std::cout << "Cost of the edge: " << cost << std::endl;
        }
        catch (...) {
            std::cout << "Invalid input" << std::endl;
        }
    }

    void show_number_of_vertices() {
        std::cout << "Number of vertices: " << _repository->get_number_of_vertices() << std::endl;
    }

    void show_number_of_edges() {
        std::cout << "Number of edges: " << _repository->get_number_of_edges() << std::endl;
    }

    void see_random_graph() {
        auto random_graph = FileRepository::create_random_graph();
        auto dictionary_of_costs = random_graph.get_dictCost();
        auto number_of_vertices = random_graph.get_number_of_vertices();
        auto number_of_edges = random_graph.get_number_of_edges();
        std::cout << "We have " << number_of_vertices << " vertices and " << number_of_edges << " edges" << std::endl;
        for (const auto& key : dictionary_of_costs) {
            std::cout << "Edge starting from " << key.first.first << " ending in " << key.first.second
                << " with the cost " << key.second << std::endl;
        }

        auto dictionary_out = random_graph.get_dictOut();
        for (const auto& key : dictionary_out) {
            if (dictionary_out[key.first].empty()) {
                std::cout << "Empty node " << key.first << std::endl;
            }
        }
    }

    void show_out_degree() {
        try {
            int vertex;
            std::cout << "Give vertex: ";
            std::cin >> vertex;
            std::cout << "Out degree of vertex " << vertex << " is " << _repository->get_out_degree(vertex) << std::endl;
        }
        catch (...) {
            std::cout << "Invalid input" << std::endl;
        }
    }

    void show_in_degree() {
        try {
            int vertex;
            std::cout << "Give vertex: ";
            std::cin >> vertex;
            std::cout << "In degree of vertex " << vertex << " is " << _repository->get_in_degree(vertex) << std::endl;
        }
        catch (...) {
            std::cout << "Invalid input" << std::endl;
        }
    }

    void parse_outbound_edges() {
        try {
            int vertex;
            std::cout << "Give vertex: ";
            std::cin >> vertex;
            auto outbound_edges = _repository->parse_outbound_edges(vertex);
            std::cout << "Outbound edges of vertex " << vertex << ": ";
            for (int edge : outbound_edges) {
                std::cout << edge << " ";
            }
            std::cout << std::endl;
        }
        catch (...) {
            std::cout << "Invalid input" << std::endl;
        }
    }

    void parse_inbound_edges() {
        try {
            int vertex;
            std::cout << "Give vertex: ";
            std::cin >> vertex;
            auto inbound_edges = _repository->parse_inbound_edges(vertex);
            std::cout << "Inbound edges of vertex " << vertex << ": ";
            for (int edge : inbound_edges) {
                std::cout << edge << " ";
            }
            std::cout << std::endl;
        }
        catch (...) {
            std::cout << "Invalid input" << std::endl;
        }
    }

    void start() {
        while (true) {
            print_menu();
            std::cout << "> ";
            std::string command;
            std::cin >> command;
            if (command == "2") {
                add_edge();
            }
            else if (command == "1") {
                see_graph_you_have();
            }
            else if (command == "0") {
                return;
            }
            else if (command == "3") {
                remove_edge();
            }
            else if (command == "4") {
                add_vertex();
            }
            else if (command == "5") {
                remove_vertex();
            }
            else if (command == "6") {
                modify_cost();
            }
            else if (command == "7") {
                show_number_of_vertices();
            }
            else if (command == "8") {
                show_number_of_edges();
            }
            else if (command == "9") {
                see_random_graph();
            }
            else if (command == "10") {
                show_out_degree();
            }
            else if (command == "11") {
                show_in_degree();
            }
            else if (command == "12") {
                parse_outbound_edges();
            }
            else if (command == "13") {
                parse_inbound_edges();
            }
            else if (command == "14") {
                retrieve_cost();
            }
        }
    }
};

int main() {
    FileRepository file_repository;
    UI ui(&file_repository);
    ui.start();
    return 0;
}
