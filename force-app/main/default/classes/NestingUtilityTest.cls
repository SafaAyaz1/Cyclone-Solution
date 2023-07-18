@IsTest
private class NestingUtilityTest {
    @IsTest
    static void testIsProperlyNested() {
        // Test case 1: Valid nesting
        String validText = '(ABC[123{XYZ}])';
        Boolean isValid = NestingCheckerUtility.isProperlyNested(validText);
        System.assertEquals(true, isValid, 'Expected validText to be properly nested');

        // Test case 2: Invalid nesting
        String invalidText = '(ABC[123{XYZ})]';
        Boolean isInvalid = NestingCheckerUtility.isProperlyNested(invalidText);
        System.assertEquals(true, isInvalid, 'Expected invalidText to be improperly nested');

        // Test case 3: Empty text
        String emptyText = '';
        Boolean isEmpty = NestingCheckerUtility.isProperlyNested(emptyText);
        System.assertEquals(true, isEmpty, 'Expected emptyText to be properly nested');

        // Test case 4: No nesting symbols
        String noNestingText = 'No nesting symbols';
        Boolean isNoNesting = NestingCheckerUtility.isProperlyNested(noNestingText);
        System.assertEquals(true, isNoNesting, 'Expected noNestingText to be properly nested');

        // Test case 5: Nested symbols without closing
        String unclosedText = '(ABC[123{XYZ]';
        Boolean isUnclosed = NestingCheckerUtility.isProperlyNested(unclosedText);
        System.assertEquals(false, isUnclosed, 'Expected unclosedText to be improperly nested');

        // Test case 6: Nested symbols without opening
        String unopenedText = 'ABC]123}XYZ)';
        Boolean isUnopened = NestingCheckerUtility.isProperlyNested(unopenedText);
        System.assertEquals(false, isUnopened, 'Expected unopenedText to be improperly nested');
    }
}