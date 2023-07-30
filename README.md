# Nesting Challenge - Part 1: Backend and Frontend

The Nesting Challenge project aims to create a custom Widget record with two fields: "Value" and "Is Properly Nested." Additionally, a scheduled job checks for new Widgets every hour, verifying whether the "Value" is properly nested based on specific criteria. Depending on the result, the "Is Properly Nested" field is set accordingly, and if not properly nested, an email is sent to the widget's owner.

This repository contains both the backend and frontend components of the Nesting Challenge project.

## Backend

### Requirements:

1. Custom Widget Object: A custom object named "Widget" with the following fields:
   - "Value": A text field that can store as many characters as allowed by Salesforce.
   - "Is Properly Nested": A checkbox field.

2. Scheduled Job: A scheduled job that runs hourly and checks for new Widgets. For each new Widget, the backend evaluates whether the "Value" is properly nested.

3. Properly Nested Criteria: The backend evaluates the "Value" field to ensure that any combination of parentheses (), square brackets [], and curly braces {} are matched and nested correctly. For example: "( { [ ] } )" is properly nested, while "{ [ ( ] ) }" is not.

4. Email Notification: If a Widget's "Value" is not properly nested, an email notification is sent to the Widget's owner.

5. Permission Control: System Administrators and users with a custom profile called "Widget Masters" can save Widgets even if they are not properly nested. Regular users can only save properly nested Widgets.

### Deployment and Testing:

To ensure deployability and maintainability, the solution meets the following criteria:

1. Test Coverage: The project has a minimum test coverage of 90%.

2. Automated Testing: The git repository is connected to an automated build-test-release pipeline to ensure all tests pass before deployment.

## Front-End

### Requirements:

1. Modern User Interface: A modern user interface that allows users to input text for Widgets.

2. Proper Nesting Check: The frontend includes logic to verify whether the entered text is properly nested on the client-side to provide a better user experience.

3. Save to Widget Record: All users can save properly nested Widgets using the frontend component.

4. Permission Control: Only System Administrators and users with the "Widget Masters" profile can save Widgets that are not properly nested.

### Testing:

Automated tests for the frontend components have been implemented to improve code quality and ensure a robust frontend

