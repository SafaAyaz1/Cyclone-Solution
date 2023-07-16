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
                countParentheses--;
                if (countParentheses < 0) {
                    return false;
                }
            } else if (c.equals('[')) {
                countBrackets++;
            } else if (c.equals(']')) {
                countBrackets--;
                if (countBrackets < 0) {
                    return false;
                }
            } else if (c.equals('{')) {
                countBraces++;
            } else if (c.equals('}')) {
                countBraces--;
                if (countBraces < 0) {
                    return false;
                }
            }
        }

        return countParentheses == 0 && countBrackets == 0 && countBraces == 0;
    }
}