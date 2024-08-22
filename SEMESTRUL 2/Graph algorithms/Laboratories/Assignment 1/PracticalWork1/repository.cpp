#include <unordered_map>
#include <vector>
#include <stdexcept>
#include <algorithm> // for std::remove
#include <iostream>


using namespace std;

class DoubleDictGraph {
private:
    std::unordered_map<int, std::vector<int>> _dictOut; // successors
    std::unordered_map<int, std::vector<int>> _dictIn;  // predecessors
    std::unordered_map<std::pair<int, int>, int> _dictCost;

public:

    DoubleDictGraph() = default;

    DoubleDictGraph(int n) {
        for (int i = 0; i < n; ++i) {
            _dictOut[i] = {};
            _dictIn[i] = {};
        }
    }

    DoubleDictGraph(const DoubleDictGraph& other)
        : _dictCost(other._dictCost), _dictOut(other._dictOut), _dictIn(other._dictIn) {}

    DoubleDictGraph& operator=(const DoubleDictGraph& other) {
        if (this != &other) {
            // Implement deep copy of member variables here
        }
        return *this;
    }

    int get_number_of_vertices() const {
        return _dictOut.size();
    }

    int get_number_of_edges() const {
        return _dictCost.size();
    }

    std::vector<int> parse_noduri() const {
        std::vector<int> vertices;
        for (const auto& kv : _dictOut) {
            vertices.push_back(kv.first);
        }
        return vertices;
    }

    bool is_edge(int start, int end) const {
        auto it = std::find(_dictOut.at(start).begin(), _dictOut.at(start).end(), end);
        return it != _dictOut.at(start).end();
    }

    int get_in_degree(int nod) const {
        if (nod >= get_number_of_vertices())
            throw std::invalid_argument("Invalid vertex!");
        return _dictIn.at(nod).size();
    }

    int get_out_degree(int nod) const {
        if (nod >= get_number_of_vertices())
            throw std::invalid_argument("Invalid vertex!");
        return _dictOut.at(nod).size();
    }

    std::vector<int> parse_outbound_edges(int nod) const {
        return _dictOut.at(nod);
    }

    std::vector<int> parse_inbound_edges(int nod) const {
        return _dictIn.at(nod);
    }

    void add_edge(int start, int end, int cost) {
        if (is_edge(start, end))
            throw std::invalid_argument("Edge already exists!");
        _dictOut[start].push_back(end);
        _dictIn[end].push_back(start);
        _dictCost[{start, end}] = cost;
    }

    void remove_edge(int start, int end) {
        if (!is_edge(start, end))
            throw std::invalid_argument("Edge does not exist!");
        _dictOut[start].erase(std::remove(_dictOut[start].begin(), _dictOut[start].end(), end), _dictOut[start].end());
        _dictIn[end].erase(std::remove(_dictIn[end].begin(), _dictIn[end].end(), start), _dictIn[end].end());
        _dictCost.erase({ start, end });
    }

    void add_nod(int id) {
        _dictOut[id] = {};
        _dictIn[id] = {};
    }

    void remove_nod(int id) {
        if (_dictOut.find(id) == _dictOut.end())
            throw std::invalid_argument("Vertex does not exist!");
        for (int succ : _dictOut[id]) {
            _dictIn[succ].erase(std::remove(_dictIn[succ].begin(), _dictIn[succ].end(), id), _dictIn[succ].end());
            _dictCost.erase({ id, succ });
        }
        for (int pred : _dictIn[id]) {
            _dictOut[pred].erase(std::remove(_dictOut[pred].begin(), _dictOut[pred].end(), id), _dictOut[pred].end());
        }
        _dictOut.erase(id);
        _dictIn.erase(id);
    }

    void retrieve_cost(int start, int end) {
        auto it = _dictCost.find({ start, end });
        if (it != _dictCost.end()) {
            _dictCost.erase(it);
        }
        else {
            throw std::invalid_argument("Edge does not exist!");
        }
    }

    void modify_cost(int start, int end, int newcost) {
        auto it = _dictCost.find({ start, end });
        if (it != _dictCost.end()) {
            _dictCost[{start, end}] = newcost;
        }
        else {
            throw std::invalid_argument("Edge does not exist!");
        }
    }

    std::unordered_map<int, std::vector<int>> get_dictIn() const {
        return _dictIn;
    }

    std::unordered_map<int, std::vector<int>> get_dictOut() const {
        return _dictOut;
    }

    std::unordered_map<std::pair<int, int>, int> get_dictCost() const {
        return _dictCost;
    }

    DoubleDictGraph get_graf() const {
        return *this;
    }

    void printAll() const {
        for (const auto& kv : _dictOut) {
            std::cout << "Outbound edges of vertex " << kv.first << ": ";
            for (int edge : kv.second) {
                std::cout << edge << " ";
            }
            std::cout << std::endl;
        }
        for (const auto& kv : _dictIn) {
            std::cout << "Inbound edges of vertex " << kv.first << ": ";
            for (int edge : kv.second) {
                std::cout << edge << " ";
            }
            std::cout << std::endl;
        }
        for (const auto& kv : _dictCost) {
            std::cout << "Edge from " << kv.first.first << " to " << kv.first.second << " with cost " << kv.second << std::endl;
        }
    }
};
