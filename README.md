# DiffSync

DiffSync is a PowerShell-based tool designed to compare two directories and identify modified files. It outputs only the files that have differences in content between the two directories and generates a detailed log with the differences found.

## Features

- **Directory Comparison**: Compares two directories and identifies files with content differences.
- **Selective Output**: Generates a single output directory containing only the modified files from the second directory.
- **Detailed Logging**: Creates a log file with detailed information about the differences between files.

## Getting Started

### Prerequisites

- **PowerShell**: This script is written in PowerShell and requires a compatible environment to run.

### Installation

1. **Clone the repository**:
    ```bash
    git clone https://github.com/RicardoFz/DiffSync.git
    ```
2. **Navigate to the directory**:
    ```bash
    cd DiffSync
    ```

### Usage

1. Open PowerShell and navigate to the directory containing the `DiffSync` script.
2. Run the script:
    ```powershell
    .\DiffSync.ps1
    ```
3. You will be prompted to enter the paths for the two directories you want to compare:
    - `Directory A`: The original directory.
    - `Directory B`: The directory to be compared against `Directory A`.

4. The tool will compare the directories, generate a log file with the differences, and create an output folder containing only the modified files from `Directory B`.

### Example

```powershell
Digite o caminho da primeira pasta: C:\path\to\directoryA
Digite o caminho da segunda pasta: C:\path\to\directoryB


### Output

After the comparison, the script will create:

Output Directory: A folder named directoryB_output containing all the modified files from Directory B.
Log File: A comparison_log.txt file with detailed information about the differences found.
Contributing
Contributions are welcome! Please feel free to submit a Pull Request or open an Issue to discuss improvements, new features, or bug fixes.

```License
This project is licensed under the MIT License - see the LICENSE file for details.

```Contact
For any inquiries, feel free to reach out at j.ricardo.ferreira@hotmail.com.
