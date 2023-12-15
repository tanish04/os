// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~QUES-3~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

/*Write a programme (using fork() and/or exec() commands) where parent and child
execute:
i. same program, same code.
ii. same program, different code.
iii. Before terminating, the parent waits for the child to finish its task*/

// #include <iostream>
// #include <unistd.h>
// #include <sys/wait.h>

// int main() {
//     // i. Same program, same code
//     pid_t pid = fork();

//     if (pid == -1) {
//         std::cerr << "Fork failed" << std::endl;
//         return 1;
//     }

//     if (pid == 0) {
//         // Child process
//         std::cout << "Child process executing same program, same code." << std::endl;
//         // Add the child process code here if needed
//     } else {
//         // Parent process
//         std::cout << "Parent process executing same program, same code." << std::endl;
//         wait(nullptr); // Wait for the child process to finish
//     }

//     // ii. Same program, different code
//     pid = fork();

//     if (pid == -1) {
//         std::cerr << "Fork failed" << std::endl;
//         return 1;
//     }

//     if (pid == 0) {
//         // Child process
//         std::cout << "Child process executing same program, different code." << std::endl;
//         // Add the different child process code here if needed
//     } else {
//         // Parent process
//         std::cout << "Parent process executing same program, different code." << std::endl;
//         wait(nullptr); // Wait for the child process to finish
//     }

//     return 0;
// }


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~QUES-4~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


/*Write a program to to report behaviour of Linux kernel including kernel version,
 CPU type and model. (CPU information)*/

// #include <iostream>
// #include <fstream>
// #include <string>

// int main() {
//     // Read Linux kernel version
//     std::ifstream kernelVersionFile("/proc/version");
//     if (kernelVersionFile.is_open()) {
//         std::string kernelVersion;
//         std::getline(kernelVersionFile, kernelVersion);
//         std::cout << "Linux Kernel Version: " << kernelVersion << std::endl;
//         kernelVersionFile.close();
//     } else {
//         std::cerr << "Unable to open /proc/version" << std::endl;
//         return 1;
//     }

//     // Read CPU information
//     std::ifstream cpuInfoFile("/proc/cpuinfo");
//     if (cpuInfoFile.is_open()) {
//         std::string line;
//         while (std::getline(cpuInfoFile, line)) {
//             std::cout << line << std::endl;
//         }
//         cpuInfoFile.close();
//     } else {
//         std::cerr << "Unable to open /proc/cpuinfo" << std::endl;
//         return 1;
//     }

//     return 0;
// }


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~QUES-5~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


/*Write a program to report behaviour of Linux kernel including information on 19
configured memory, amount of free and used memory. (Memory information)*/

// #include <iostream>
// #include <fstream>
// #include <sstream>
// #include <string>

// // Function to convert KB to GB
// double kbToGb(unsigned long kb) {
//     return static_cast<double>(kb) / (1024 * 1024);
// }

// int main() {
//     std::ifstream meminfoFile("/proc/meminfo");

//     if (meminfoFile.is_open()) {
//         std::string line;
//         while (std::getline(meminfoFile, line)) {
//             std::istringstream iss(line);
//             std::string key;
//             unsigned long value;

//             if (iss >> key >> value) {
//                 if (key == "MemTotal:") {
//                     std::cout << "Total Configured Memory: " << kbToGb(value) << " GB" << std::endl;
//                 } else if (key == "MemFree:") {
//                     std::cout << "Free Memory: " << kbToGb(value) << " GB" << std::endl;
//                 } else if (key == "MemAvailable:") {
//                     std::cout << "Available Memory: " << kbToGb(value) << " GB" << std::endl;
//                 }
//             }
//         }

//         meminfoFile.close();
//     } else {
//         std::cerr << "Unable to open /proc/meminfo" << std::endl;
//         return 1;
//     }

//     return 0;
// }



// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~QUES-6~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

/*Write a program to copy files using system calls*/

// #include <iostream>
// #include <fstream>
// #include <fcntl.h>
// #include <unistd.h>

// #define BUFFER_SIZE 4096

// int main(int argc, char *argv[]) {
//     if (argc != 3) {
//         std::cerr << "Usage: " << argv[0] << " <source_file> <destination_file>" << std::endl;
//         return 1;
//     }

//     const char *sourceFile = argv[1];
//     const char *destinationFile = argv[2];

//     // Open the source file for reading
//     int sourceFd = open(sourceFile, O_RDONLY);
//     if (sourceFd == -1) {
//         perror("Error opening source file");
//         return 1;
//     }

//     // Create or truncate the destination file for writing
//     int destinationFd = open(destinationFile, O_WRONLY | O_CREAT | O_TRUNC, 0666);
//     if (destinationFd == -1) {
//         perror("Error opening destination file");
//         close(sourceFd);
//         return 1;
//     }

//     // Copy data from source to destination
//     char buffer[BUFFER_SIZE];
//     ssize_t bytesRead, bytesWritten;

//     while ((bytesRead = read(sourceFd, buffer, BUFFER_SIZE)) > 0) {
//         bytesWritten = write(destinationFd, buffer, bytesRead);
//         if (bytesWritten != bytesRead) {
//             perror("Error writing to destination file");
//             close(sourceFd);
//             close(destinationFd);
//             return 1;
//         }
//     }

//     if (bytesRead == -1) {
//         perror("Error reading from source file");
//         close(sourceFd);
//         close(destinationFd);
//         return 1;
//     }

//     // Close file descriptors
//     close(sourceFd);
//     close(destinationFd);

//     std::cout << "File copy successful: " << sourceFile << " -> " << destinationFile << std::endl;

//     return 0;
// }

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~QUES-7~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

/*Use an operating system simulator to simulate operating system tasks*/

// #include <iostream>
// #include <queue>
// #include <vector>

// // Process structure
// struct Process {
//     int id;
//     int burstTime;
// };

// // Function to simulate round-robin scheduling
// void roundRobinScheduling(const std::vector<Process>& processes, int timeQuantum) {
//     std::queue<Process> processQueue;

//     int currentTime = 0;
//     int totalProcesses = processes.size();
//     int processedProcesses = 0;

//     while (processedProcesses < totalProcesses) {
//         for (const Process& process : processes) {
//             if (process.burstTime > 0 && processQueue.empty()) {
//                 processQueue.push(process);
//             }
//         }

//         if (!processQueue.empty()) {
//             Process currentProcess = processQueue.front();
//             processQueue.pop();

//             int executionTime = std::min(timeQuantum, currentProcess.burstTime);
//             currentTime += executionTime;
//             currentProcess.burstTime -= executionTime;

//             std::cout << "Executing Process " << currentProcess.id << " for " << executionTime << " units. ";

//             if (currentProcess.burstTime == 0) {
//                 processedProcesses++;
//                 std::cout << "Process " << currentProcess.id << " completed.";
//             } else {
//                 processQueue.push(currentProcess);
//                 std::cout << "Process " << currentProcess.id << " partially executed.";
//             }

//             std::cout << " Current Time: " << currentTime << std::endl;
//         } else {
//             currentTime++;
//         }
//     }
// }

// int main() {
//     // Create some example processes
//     std::vector<Process> processes = {
//         {1, 10},
//         {2, 5},
//         {3, 8}
//         // Add more processes as needed
//     };

//     // Set time quantum for round-robin scheduling
//     int timeQuantum = 2;

//     // Simulate round-robin scheduling
//     roundRobinScheduling(processes, timeQuantum);

//     return 0;
// }


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~QUES-8~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

/*Write a program to implement scheduling algorithms FCFS/ SJF/ SRTF/ nonpreemptive scheduling algorithms.*/

// #include <iostream>
// #include <vector>
// #include <algorithm>

// using namespace std;

// // Process structure
// struct Process {
//     int id;
//     int burstTime;
//     int priority;
// };

// // Function to implement FCFS scheduling
// void fcfs(vector<Process>& processes) {
//     cout << "FCFS Scheduling:\n";
//     int n = processes.size();
//     int currentTime = 0;

//     for (const Process& process : processes) {
//         cout << "Process " << process.id << " starts at time " << currentTime << " and ends at time " << currentTime + process.burstTime << endl;
//         currentTime += process.burstTime;
//     }
// }

// // Function to implement SJF scheduling
// void sjf(vector<Process>& processes) {
//     cout << "SJF Scheduling:\n";
//     int n = processes.size();

//     sort(processes.begin(), processes.end(), [](const Process& a, const Process& b) {
//         return a.burstTime < b.burstTime;
//     });

//     int currentTime = 0;
//     for (const Process& process : processes) {
//         cout << "Process " << process.id << " starts at time " << currentTime << " and ends at time " << currentTime + process.burstTime << endl;
//         currentTime += process.burstTime;
//     }
// }

// // Function to implement SRTF scheduling
// void srtf(vector<Process>& processes) {
//     cout << "SRTF Scheduling:\n";
//     int n = processes.size();
//     int currentTime = 0;

//     sort(processes.begin(), processes.end(), [](const Process& a, const Process& b) {
//         return a.burstTime < b.burstTime;
//     });

//     vector<Process> remainingProcesses = processes;

//     while (!remainingProcesses.empty()) {
//         auto shortest = min_element(remainingProcesses.begin(), remainingProcesses.end(), [currentTime](const Process& a, const Process& b) {
//             return a.burstTime < b.burstTime && a.burstTime > 0 && a.priority == currentTime;
//         });

//         if (shortest != remainingProcesses.end()) {
//             cout << "Process " << shortest->id << " starts at time " << currentTime << " and ends at time " << currentTime + 1 << endl;
//             currentTime += 1;
//             shortest->burstTime -= 1;

//             // Remove completed process
//             if (shortest->burstTime == 0) {
//                 remainingProcesses.erase(shortest);
//             }
//         } else {
//             currentTime += 1;
//         }
//     }
// }

// // Function to implement non-preemptive priority scheduling
// void priorityScheduling(vector<Process>& processes) {
//     cout << "Non-Preemptive Priority Scheduling:\n";
//     int n = processes.size();

//     sort(processes.begin(), processes.end(), [](const Process& a, const Process& b) {
//         return a.priority < b.priority;
//     });

//     int currentTime = 0;
//     for (const Process& process : processes) {
//         cout << "Process " << process.id << " starts at time " << currentTime << " and ends at time " << currentTime + process.burstTime << endl;
//         currentTime += process.burstTime;
//     }
// }

// int main() {
//     int n;
//     cout << "Enter the number of processes: ";
//     cin >> n;

//     vector<Process> processes(n);

//     for (int i = 0; i < n; ++i) {
//         processes[i].id = i + 1;
//         cout << "Enter burst time for Process " << i + 1 << ": ";
//         cin >> processes[i].burstTime;
//         cout << "Enter priority for Process " << i + 1 << ": ";
//         cin >> processes[i].priority;
//     }

//     int choice;
//     cout << "Choose scheduling algorithm:\n";
//     cout << "1. FCFS\n2. SJF\n3. SRTF\n4. Non-Preemptive Priority\n";
//     cout << "Enter your choice (1-4): ";
//     cin >> choice;

//     switch (choice) {
//         case 1:
//             fcfs(processes);
//             break;
//         case 2:
//             sjf(processes);
//             break;
//         case 3:
//             srtf(processes);
//             break;
//         case 4:
//             priorityScheduling(processes);
//             break;
//         default:
//             cout << "Invalid choice\n";
//             break;
//     }

//     return 0;
// }



// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~QUES-9~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

/*Write a program to calculate the sum of n numbers using Pthreads. A list of n numbers
is divided into two smaller lists of equal size, and two separate threads are used to sum
the sublists.*/

#include <iostream>

int main() {
    std::cout << "%%%%  %%%%   %%%%%   %%%   %%%%\n";
    std::cout << "%     %   %  %   %  %   %  %   %\n";
    std::cout << "%%%%  %%%%   %%%%   %   %  %%%%\n";
    std::cout << "%     %   %  %   %  %   %  %   %\n";
    std::cout << "%%%%  %   %  %   %   %%%   %   %\n";

    return 0;
}

// #include <iostream>
// #include <pthread.h>
// #include <vector>

// using namespace std;

// // Structure to pass data to the thread function
// struct ThreadData {
//     vector<int>* numbers;
//     int startIndex;
//     int endIndex;
//     int sum;
// };

// // Thread function to calculate the sum of a sublist
// void* calculateSum(void* data) {
//     ThreadData* threadData = static_cast<ThreadData*>(data);
//     vector<int>& numbers = *(threadData->numbers);
//     int startIndex = threadData->startIndex;
//     int endIndex = threadData->endIndex;
//     int& sum = threadData->sum;

//     for (int i = startIndex; i <= endIndex; ++i) {
//         sum += numbers[i];
//     }

//     return nullptr;
// }

// int main() {
//     int n;
//     cout << "Enter the number of elements: ";
//     cin >> n;

//     vector<int> numbers(n);
//     cout << "Enter " << n << " numbers:\n";
//     for (int i = 0; i < n; ++i) {
//         cin >> numbers[i];
//     }

//     // Divide the list into two equal sublists
//     int mid = n / 2;

//     // Create thread data for the first sublist
//     ThreadData threadData1 = {&numbers, 0, mid - 1, 0};
//     pthread_t thread1;
//     pthread_create(&thread1, nullptr, calculateSum, &threadData1);

//     // Create thread data for the second sublist
//     ThreadData threadData2 = {&numbers, mid, n - 1, 0};
//     pthread_t thread2;
//     pthread_create(&thread2, nullptr, calculateSum, &threadData2);

//     // Wait for both threads to finish
//     pthread_join(thread1, nullptr);
//     pthread_join(thread2, nullptr);

//     // Calculate the total sum
//     int totalSum = threadData1.sum + threadData2.sum;

//     cout << "Sum of the numbers: " << totalSum << endl;

//     return 0;
// }



// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~QUES-10~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

/*Write a program to implement first-fit, best-fit and worst-fit allocation strategies.*/

// #include <iostream>
// #include <vector>
// #include <algorithm>

// using namespace std;

// struct Block {
//     int size;
//     int processId;
// };

// void firstFit(vector<Block>& memory, int processId, int processSize) {
//     for (int i = 0; i < memory.size(); ++i) {
//         if (memory[i].size >= processSize) {
//             memory[i].size -= processSize;
//             memory[i].processId = processId;
//             cout << "Process " << processId << " allocated using First Fit in Block " << i << endl;
//             return;
//         }
//     }
//     cout << "Process " << processId << " cannot be allocated using First Fit" << endl;
// }

// void bestFit(vector<Block>& memory, int processId, int processSize) {
//     auto bestFitBlock = min_element(memory.begin(), memory.end(), [processSize](const Block& a, const Block& b) {
//         return (a.size >= processSize) < (b.size >= processSize);
//     });

//     if (bestFitBlock != memory.end() && bestFitBlock->size >= processSize) {
//         bestFitBlock->size -= processSize;
//         bestFitBlock->processId = processId;
//         cout << "Process " << processId << " allocated using Best Fit in Block " << distance(memory.begin(), bestFitBlock) << endl;
//     } else {
//         cout << "Process " << processId << " cannot be allocated using Best Fit" << endl;
//     }
// }

// void worstFit(vector<Block>& memory, int processId, int processSize) {
//     auto worstFitBlock = max_element(memory.begin(), memory.end(), [processSize](const Block& a, const Block& b) {
//         return (a.size >= processSize) < (b.size >= processSize);
//     });

//     if (worstFitBlock != memory.end() && worstFitBlock->size >= processSize) {
//         worstFitBlock->size -= processSize;
//         worstFitBlock->processId = processId;
//         cout << "Process " << processId << " allocated using Worst Fit in Block " << distance(memory.begin(), worstFitBlock) << endl;
//     } else {
//         cout << "Process " << processId << " cannot be allocated using Worst Fit" << endl;
//     }
// }

// int main() {
//     int memorySize, numBlocks;
//     cout << "Enter the total memory size: ";
//     cin >> memorySize;

//     cout << "Enter the number of memory blocks: ";
//     cin >> numBlocks;

//     vector<Block> memory(numBlocks, {memorySize / numBlocks, -1});

//     int numProcesses;
//     cout << "Enter the number of processes: ";
//     cin >> numProcesses;

//     for (int i = 1; i <= numProcesses; ++i) {
//         int processSize;
//         cout << "Enter the size of Process " << i << ": ";
//         cin >> processSize;

//         // Uncomment the strategy you want to test
//         // firstFit(memory, i, processSize);
//         // bestFit(memory, i, processSize);
//         // worstFit(memory, i, processSize);
//     }

//     return 0;
// }

