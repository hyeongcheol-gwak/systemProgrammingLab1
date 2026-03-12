#include <stdio.h>
#include <stdlib.h>

// DFA States
enum State {
    NORMAL,
    SLASH,
    MULTI,
    STAR,
    SINGLE,
    STRING,
    STR_ESC,
    CHAR,
    CHAR_ESC
};

// Global variables for line tracking
int current_line = 1;
int comment_line = 0;

// Function prototypes to satisfy strict compilation
enum State handle_normal_state(int c);
enum State handle_slash_state(int c);
enum State handle_multi_state(int c);
enum State handle_star_state(int c);
enum State handle_single_state(int c);
enum State handle_string_state(int c);
enum State handle_char_state(int c);

// reads chars from stdin and transitions DFA states.
int main(void) {
    int c;
    enum State state = NORMAL;

    while ((c = getchar()) != EOF) {
        /* Update line count for all states except multi-line
           comment internal logic, which handles its own newlines */
        if (c == '\n' && state != MULTI && state != STAR) {
            current_line++;
        }

        switch (state) {
            case NORMAL:   state = handle_normal_state(c); break;
            case SLASH:    state = handle_slash_state(c); break;
            case MULTI:    state = handle_multi_state(c); break;
            case STAR:     state = handle_star_state(c); break;
            case SINGLE:   state = handle_single_state(c); break;
            case STRING:   state = handle_string_state(c); break;
            case CHAR:     state = handle_char_state(c); break;
            case STR_ESC:  putchar(c); state = STRING; break;
            case CHAR_ESC: putchar(c); state = CHAR; break;
            default:       break;
        }
    }

    // Edge case: '/' at the end of file
    if (state == SLASH) {
        putchar('/');
    }

    // Final check for unterminated block comments
    if (state == MULTI || state == STAR) {
        fprintf(stderr, "Error: line %d: unterminated comment\n",
                comment_line);
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}

// Handle normal code outside of comments/strings
enum State handle_normal_state(int c) {
    if (c == '/') return SLASH;
    putchar(c);
    if (c == '\"') return STRING;
    if (c == '\'') return CHAR;
    return NORMAL;
}

// Handle single slash - potential start of a comment
enum State handle_slash_state(int c) {
    if (c == '*') {
        putchar(' ');
        comment_line = current_line;
        return MULTI;
    }
    if (c == '/') {
        putchar(' ');
        return SINGLE;
    }
    // Not a comment: output previous slash and current char
    putchar('/');
    if (c == '\"') { putchar(c); return STRING; }
    if (c == '\'') { putchar(c); return CHAR; }
    if (c == '/') return SLASH;
    putchar(c);
    return NORMAL;
}

// Inside block comment
enum State handle_multi_state(int c) {
    if (c == '*') return STAR;
    if (c == '\n') {
        putchar('\n');
        current_line++;
    }
    return MULTI;
}

// Inside block comment after a star
enum State handle_star_state(int c) {
    if (c == '/') return NORMAL;
    if (c == '*') return STAR;
    if (c == '\n') {
        putchar('\n');
        current_line++;
        return MULTI;
    }
    return MULTI;
}

// Inside single-line comment
enum State handle_single_state(int c) {
    if (c == '\n') {
        putchar('\n');
        return NORMAL;
    }
    return SINGLE;
}

// Inside string literal
enum State handle_string_state(int c) {
    putchar(c);
    if (c == '\\') return STR_ESC;
    if (c == '\"') return NORMAL;
    return STRING;
}

// Inside char constant
enum State handle_char_state(int c) {
    putchar(c);
    if (c == '\\') return CHAR_ESC;
    if (c == '\'') return NORMAL;
    return CHAR;
}