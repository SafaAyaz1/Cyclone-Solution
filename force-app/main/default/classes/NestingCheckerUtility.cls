public class NestingCheckerUtility {
    public static Boolean isProperlyNested(String text) {
        Integer countParentheses = 0;
        Integer countBrackets = 0;
        Integer countBraces = 0;

        for (Integer i = 0; i < text.length(); i++) {
            String c = text.substring(i, i + 1);

            if (c.equals('(')) {
                countParentheses++;
            } else if (c.equals(')')) {
                if (countParentheses == 0) {
                    return false;
                }
                countParentheses--;
            } else if (c.equals('[')) {
                countBrackets++;
            } else if (c.equals(']')) {
                if (countBrackets == 0) {
                    return false;
                }
                countBrackets--;
            } else if (c.equals('{')) {
                countBraces++;
            } else if (c.equals('}')) {
                if (countBraces == 0) {
                    return false;
                }
                countBraces--;
            }
        }

        return countParentheses == 0 && countBrackets == 0 && countBraces == 0;
    }
}