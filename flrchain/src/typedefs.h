#ifndef TYPEDEFS_H
#define TYPEDEFS_H

#include <QSharedPointer>

#define DECLARE_SHARED_POINTER(TYPE) \
    class TYPE; \
    using TYPE##Ptr = QSharedPointer<TYPE>; \
    using TYPE##List = QList<TYPE##Ptr>;

DECLARE_SHARED_POINTER(User)
DECLARE_SHARED_POINTER(Project)
DECLARE_SHARED_POINTER(Action)
DECLARE_SHARED_POINTER(Milestone)
DECLARE_SHARED_POINTER(Task)
DECLARE_SHARED_POINTER(DataTag)

#endif // TYPEDEFS_H
