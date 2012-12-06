#include <assert.h>
#include <stdbool.h>
#include "util.h"

#define MAX_LINKED_DOTS_COUNT 400

linked_node *header;

void insertDot(dot *d) 
{
    assert(d!= NULL);

    linked_node* node = (linked_node*)malloc(sizeof(linked_node));
    node->dot = d;
    node->next = header;
    header = node;
}

linked_node* getHeaderNode()
{
    return header;
}

/*
 * TODO This function can't past test.
 */
bool deleteDot(dot *d)
{
    assert(d != NULL);

    linked_node *cur = header;
    linked_node *prev = NULL;
    while (cur) {
        if (cur->dot == d) {
            if (prev == NULL) {
                header = cur->next;
            } else {
                prev -> next = cur->next;
            }
            free(cur->dot);
            free(cur);
            return true;
        }
        prev = cur;
        cur = cur->next;
    }
    return false;
}

int nodesSize()
{
    if (header == NULL) {
        return 0;
    }

    linked_node *cur = header;
    int size = 0;
    while (cur) {
        size += 1;
        cur = cur -> next;
    }
    return size;
}

void freeAllNodes()
{
    if (header == NULL) {
        return;
    }

    linked_node *prev;
    linked_node *cur = header;
    while (cur) {
        prev = cur;
        cur = cur->next;
        free(prev->dot);
        free(prev);
    }

    header = NULL;
}
