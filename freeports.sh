#!/bin/bash

array=($(netstat -tupln | awk '{print $4}' | awk  -F":" '{print $NF}') )

# Функция для удаления повторяющихся элементов
removeDups() {
    local duplicate_found=0
    local new_array=()
    local entry=${1}
			    
    for ((i=1; i<${#array[@]}; i++)); do
    	if [[ "${array[$i]}" == "$entry" ]]; then
    	duplicate_found=1
    fi
    done
									        
    if [[ $duplicate_found -eq 0 ]]; then
    new_array+=("$entry")
    fi
    return ${duplicate_found}
}

# Проходимся по массиву, вызывая функцию удаления дубликатов

exit_array={}

for ((i=0; i<${#array[@]}; i++ )); do
    removeDups ${array[$i]}

done


#Сортировка массива для отсеивания строковых значений

tmpArray=()
for i in "${array[@]}"; do
    if [[ "$i" =~ ^-?[0-9]+$ ]]; then
            # Если элемент является числом...
            tmpArray+=("$i")
    fi
done

array=("${tmpArray[@]}")

#Сортировка числового массива

IFS=$'\n'
sorted=($(sort <<<"${array[*]}"));
unset IFS


# Вывод отсортированного массива

for i in "${sorted[@]}"; do
    	
    echo "$i"
done
