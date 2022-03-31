/*
 * Copyright (C) 2022  Milo Solutions
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 */

#ifndef TYPES_H
#define TYPES_H

#include <QSharedPointer>

#define DECLARE_SHARED_POINTER(TYPE) \
    class TYPE; \
    using TYPE##Ptr = QSharedPointer<TYPE>;

#define DECLARE_SHARED_POINTER_WITH_LIST(TYPE) \
    class TYPE; \
    using TYPE##Ptr = QSharedPointer<TYPE>; \
    using TYPE##List = QList<TYPE##Ptr>;

DECLARE_SHARED_POINTER(ProjectModel)

DECLARE_SHARED_POINTER_WITH_LIST(User)
DECLARE_SHARED_POINTER_WITH_LIST(Project)
DECLARE_SHARED_POINTER_WITH_LIST(Action)
DECLARE_SHARED_POINTER_WITH_LIST(Milestone)
DECLARE_SHARED_POINTER_WITH_LIST(Task)
DECLARE_SHARED_POINTER_WITH_LIST(DataTag)

#endif // TYPES_H
