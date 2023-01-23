#include <stdint.h>
namespace App {
    void Initialize(const char *hostname, uint32_t port_number);
    void Deinitialize(); 
    void run_one_cycle();
}