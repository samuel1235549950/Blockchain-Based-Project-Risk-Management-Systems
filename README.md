# Blockchain-Based Project Risk Management System

A comprehensive risk management system built on the Stacks blockchain using Clarity smart contracts. This system provides end-to-end risk management capabilities for projects, including risk identification, mitigation planning, monitoring coordination, and response management.

## Features

### 🔐 Risk Manager Verification
- Verify and manage certified risk managers
- Track manager credentials and certifications
- Revoke verification when necessary
- Ensure only qualified personnel manage risks

### 🎯 Risk Identification
- Identify and categorize project risks
- Assign severity levels (Low, Medium, High, Critical)
- Calculate risk scores based on probability and impact
- Track risk status and lifecycle

### 📋 Mitigation Planning
- Create comprehensive mitigation strategies
- Assign action items and responsibilities
- Set target dates and budget requirements
- Track plan execution progress

### 📊 Monitoring Coordination
- Schedule regular risk monitoring tasks
- Submit monitoring reports with findings
- Track risk level changes over time
- Coordinate monitoring activities across teams

### ⚡ Response Management
- Create immediate response plans for risks
- Assign priority levels and deadlines
- Escalate responses when necessary
- Track response execution and outcomes

## Smart Contracts

### 1. Risk Manager Verification (\`risk-manager-verification.clar\`)
Manages the verification and validation of risk managers who can operate within the system.

**Key Functions:**
- \`verify-manager\`: Verify a new risk manager
- \`is-verified-manager\`: Check verification status
- \`get-manager-details\`: Retrieve manager information
- \`revoke-manager\`: Remove manager verification

### 2. Risk Identification (\`risk-identification.clar\`)
Handles the identification and categorization of project risks.

**Key Functions:**
- \`identify-risk\`: Register a new risk
- \`get-risk\`: Retrieve risk details
- \`update-risk-status\`: Update risk status
- \`calculate-risk-score\`: Calculate risk impact score

### 3. Mitigation Planning (\`mitigation-planning.clar\`)
Manages mitigation strategies and action plans for identified risks.

**Key Functions:**
- \`create-mitigation-plan\`: Create a new mitigation plan
- \`get-mitigation-plan\`: Retrieve plan details
- \`update-plan-status\`: Update plan execution status
- \`update-action-items\`: Modify action items

### 4. Monitoring Coordination (\`monitoring-coordination.clar\`)
Coordinates ongoing monitoring activities for identified risks.

**Key Functions:**
- \`create-monitoring-task\`: Schedule monitoring activities
- \`submit-monitoring-report\`: Submit monitoring findings
- \`get-monitoring-task\`: Retrieve task details
- \`get-monitoring-report\`: Access monitoring reports

### 5. Response Management (\`response-management.clar\`)
Manages immediate responses to risks and escalation procedures.

**Key Functions:**
- \`create-risk-response\`: Create response plan
- \`update-response-status\`: Update response progress
- \`escalate-response\`: Escalate to higher authority
- \`get-risk-response\`: Retrieve response details

## Installation

1. Clone the repository:
   \`\`\`bash
   git clone <repository-url>
   cd blockchain-risk-management
   \`\`\`

2. Install dependencies:
   \`\`\`bash
   npm install
   \`\`\`

3. Run tests:
   \`\`\`bash
   npm test
   \`\`\`

## Usage

### Deploying Contracts

Deploy the contracts to the Stacks blockchain in the following order:

1. Risk Manager Verification
2. Risk Identification
3. Mitigation Planning
4. Monitoring Coordination
5. Response Management

### Basic Workflow

1. **Verify Risk Managers**: Start by verifying qualified risk managers
2. **Identify Risks**: Register project risks with appropriate categorization
3. **Create Mitigation Plans**: Develop strategies to address identified risks
4. **Setup Monitoring**: Schedule regular monitoring of risk status
5. **Manage Responses**: Create and execute response plans as needed

### Example Usage

\`\`\`clarity
;; Verify a risk manager
(contract-call? .risk-manager-verification verify-manager
'ST2CY5V39NHDPWSXMW9QDT3HC3GD6Q6XX4CFRK9AG
"John Doe"
"PMP Certified")

;; Identify a risk
(contract-call? .risk-identification identify-risk
u1                    ;; project-id
"Database failure"    ;; description
"Technical"          ;; category
u3                   ;; severity (High)
u7                   ;; probability (1-10)
u8)                  ;; impact (1-10)
\`\`\`

## Testing

The system includes comprehensive tests using Vitest:

\`\`\`bash
npm test
\`\`\`

Tests cover:
- Contract deployment and initialization
- Function execution and validation
- Error handling and edge cases
- Data integrity and consistency

## Security Considerations

- **Access Control**: Only verified managers can perform critical operations
- **Data Validation**: All inputs are validated before processing
- **Immutable Records**: Risk records maintain audit trail
- **Permission Checks**: Functions verify caller permissions

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For questions or support, please open an issue in the repository or contact the development team.
