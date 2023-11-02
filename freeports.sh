#!/bin/bash

function unique_array() {
  # Объявляем переменную для хранения уникальных элементов
    local -a unique_elements=()

  # Проходим по каждому элементу массива
    for element in "${@}"; do
  # Если элемент не содержится в уникальных элементах, добавляем его
        if [[ "${unique_elements[@]}" != *"$element"* ]]; then
	      unique_elements+=("$element")
        fi
    done
    echo "${unique_elements[*]}"
   }
	
array=($(netstat -tupln | awk '{print $4}' | awk  -F":" '{print $NF}') )

sorted=()

for i in $(unique_array "${array[@]}"); do
	sorted+=("$i")
done


#Сортировка массива для отсеивания строковых значений
tmpArray=()
for i in "${sorted[@]}"; do
    if [[ "$i" =~ ^-?[0-9]+$ ]]; then
           # Если элемент является числом...
            tmpArray+=("$i")
    fi
done
array=("${tmpArray[@]}")

#Сортировка числового массива

IFS=$'\n'
sorted_last=($(sort <<<"${array[*]}"));
unset IFS


# Вывод отсортированного массива

for i in "${sorted_last[@]}"; do
    	
    echo "$i"
done
