#include <string>
#include <algorithm>
#include <iostream>
#include <random>
#include <chrono>

std::string random_string(std::string::size_type length)
{
    static auto& chrs = "0123456789"
        "abcdefghijklmnopqrstuvwxyz"
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

    thread_local static std::mt19937 rg{std::random_device{}()};
    thread_local static std::uniform_int_distribution<std::string::size_type> pick(0, sizeof(chrs) - 2);

    std::string s;
    s.reserve(length);


    while(length--)
        s += chrs[pick(rg)];

    return s;
}


template<class F, class... Args>
long time_function(F&& f, Args&&... args)
{
	std::chrono::high_resolution_clock::time_point start
	= std::chrono::high_resolution_clock::now(); 
	f(args...);
	return std::chrono::duration_cast<std::chrono::milliseconds>
		(std::chrono::high_resolution_clock::now() - start).count();
}

uint index_count(const std::string& val)
{
	uint count = 0;
	for(uint i=0; i<val.length(); ++i)
	{
		if(val[i] == 'a') ++count;
	}
	return count;
}

uint iterator_count(const std::string& val)
{
	uint count = 0;
	for(auto it = val.begin(); it!=val.end(); ++it)
	{
		if(*it == 'a') ++count;
	}
	return count;
}

uint foreach_count(const std::string& val)
{
	uint count = 0;
	for(auto c : val)
	{
		if(c == 'a') ++count;
	}
	return count;
}

uint algo_count(const std::string& val)
{
	return std::count(val.begin(), val.end(), 'a');
}
		
int main()
{
	std::string s = random_string(100000000);
	
	std::cout << "index count," << time_function(index_count, s) << std::endl;
	std::cout << "iterator count,"<< time_function(iterator_count, s) << std::endl;
	std::cout << "foreach count,"<< time_function(foreach_count, s) << std::endl;
	std::cout << "algorithm count,"<< time_function(algo_count, s) << std::endl;
}
