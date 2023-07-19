public class NestingCheckerUtility {
    public static Boolean isProperlyNested(String text) {
        // Initialize counters for parentheses, brackets, and braces
        Integer countParentheses = 0;
        Integer countBrackets = 0;
        Integer countBraces = 0;

        // Loop through each character in the 'text' input
        for (Integer i = 0; i < text.length(); i++) {
            // Get the current character in the 'text'
            String c = text.substring(i, i + 1);

            // Check for opening parentheses '('
            if (c.equals('(')) {
                countParentheses++; // Increment the parentheses counter
            } 
            // Check for closing parentheses ')'
            else if (c.equals(')')) {
                // If there are no corresponding opening parentheses, the text is not properly nested
                if (countParentheses == 0) {
                    return false;
                }
                countParentheses--; // Decrement the parentheses counter
            } 
            // Check for opening square brackets '['
            else if (c.equals('[')) {
                countBrackets++; // Increment the brackets counter
            } 
            // Check for closing square brackets ']'
            else if (c.equals(']')) {
                // If there are no corresponding opening square brackets, the text is not properly nested
                if (countBrackets == 0) {
                    return false;
                }
                countBrackets--; // Decrement the brackets counter
            } 
            // Check for opening curly braces '{'
            else if (c.equals('{')) {
                countBraces++; // Increment the braces counter
            } 
            // Check for closing curly braces '}'
            else if (c.equals('}')) {
                // If there are no corresponding opening curly braces, the text is not properly nested
                if (countBraces == 0) {
                    return false;
                }
                countBraces--; // Decrement the braces counter
            }
        }

        // After processing the entire text, check if all parentheses, brackets, and braces are properly nested
        return countParentheses == 0 && countBrackets == 0 && countBraces == 0;
    }
}
