#!/usr/bin/env node
/**
 * Script Name: javascript-template.js
 * Description: Template for JavaScript/Node.js utility scripts
 * Author: Your Name
 * Date: YYYY-MM-DD
 * Version: 1.0
 * 
 * Usage:
 *   node javascript-template.js [options]
 * 
 * Examples:
 *   node javascript-template.js --help
 *   node javascript-template.js --verbose
 */

'use strict';

const fs = require('fs');
const path = require('path');

/**
 * Custom error class for script errors
 */
class ScriptError extends Error {
    constructor(message) {
        super(message);
        this.name = 'ScriptError';
    }
}

/**
 * Logger utility
 */
const logger = {
    verbose: false,
    
    info(message) {
        console.log(`[INFO] ${message}`);
    },
    
    warn(message) {
        console.warn(`[WARN] ${message}`);
    },
    
    error(message) {
        console.error(`[ERROR] ${message}`);
    },
    
    debug(message) {
        if (this.verbose) {
            console.log(`[DEBUG] ${message}`);
        }
    }
};

/**
 * Display usage information
 */
function showUsage() {
    const scriptName = path.basename(process.argv[1]);
    console.log(`
Usage: ${scriptName} [OPTIONS]

Description of what this script does.

OPTIONS:
    -h, --help          Show this help message
    -v, --verbose       Enable verbose output
    --version           Show version information

EXAMPLES:
    ${scriptName} --help
    ${scriptName} --verbose
    `);
}

/**
 * Parse command line arguments
 * @returns {Object} Parsed arguments
 */
function parseArguments() {
    const args = {
        verbose: false,
        help: false
    };
    
    for (let i = 2; i < process.argv.length; i++) {
        const arg = process.argv[i];
        
        switch (arg) {
            case '-h':
            case '--help':
                args.help = true;
                break;
            case '-v':
            case '--verbose':
                args.verbose = true;
                break;
            case '--version':
                console.log('1.0');
                process.exit(0);
                break;
            default:
                console.error(`Unknown option: ${arg}`);
                showUsage();
                process.exit(1);
        }
    }
    
    return args;
}

/**
 * Validate input data
 * @param {string} value - Value to validate
 * @returns {boolean} True if valid
 */
function validateInput(value) {
    // Add your validation logic here
    return true;
}

/**
 * Process data
 * @param {string} data - Data to process
 * @returns {string} Processed data
 * @throws {ScriptError} If processing fails
 */
function processData(data) {
    try {
        // Add your processing logic here
        return data;
    } catch (error) {
        throw new ScriptError(`Failed to process data: ${error.message}`);
    }
}

/**
 * Main function
 * @returns {Promise<number>} Exit code
 */
async function main() {
    const args = parseArguments();
    
    if (args.help) {
        showUsage();
        return 0;
    }
    
    logger.verbose = args.verbose;
    
    try {
        logger.info('Script started');
        
        // Your script logic here
        
        logger.info('Script completed successfully');
        return 0;
        
    } catch (error) {
        if (error instanceof ScriptError) {
            logger.error(`Script error: ${error.message}`);
        } else {
            logger.error(`Unexpected error: ${error.message}`);
            if (args.verbose) {
                console.error(error.stack);
            }
        }
        return 1;
    }
}

// Handle unhandled rejections
process.on('unhandledRejection', (reason, promise) => {
    logger.error(`Unhandled rejection at: ${promise}, reason: ${reason}`);
    process.exit(1);
});

// Handle SIGINT (Ctrl+C)
process.on('SIGINT', () => {
    logger.warn('Script interrupted by user');
    process.exit(130);
});

// Execute main function if script is run directly
if (require.main === module) {
    main()
        .then(exitCode => process.exit(exitCode))
        .catch(error => {
            logger.error(`Fatal error: ${error.message}`);
            process.exit(1);
        });
}

module.exports = { processData, validateInput };
