-- Sort function
function sort(array)
    -- Initialize solved
    local solved = false
    while not solved do
        solved = true
        --[[
            Loop through array, continue to swap
            elements if first > second
        ]]
        for i = 1, #array - 1 do
            if array[i] > array[i + 1] then
                -- Swap elements
                array[i], array[i + 1] = array[i + 1], array[i]
                solved = false
            end
        end
    end
    -- Return sorted array
    return array
end

-- Write to file function
function writeToFile(array, outputFile)
    -- Open output file
    local file, err = io.open(outputFile, "w")
    -- If file write error, let user know
    if not file then
        print("Error writing to file: " .. outputFile .. " (" .. tostring(err) .. ")")
        return
    end

    -- Write each line
    for _, num in ipairs(array) do
        file:write(num .. "\n")
    end

    -- Close file, let user know
    file:close()
    print("Sorted numbers written to " .. outputFile)
end

-- Get array function
function getArray(inputFile)
    -- Open input file
    local file, err = io.open(inputFile, "r")

    -- If no input file, let user know
    if not file then
        print("\nError: The file " .. inputFile .. " was not found. " ..
              "Please ensure it exists in the same directory.")
        return {}
    end

    -- Initialize numbers table
    local numbers = {}

    -- Add each line to list as number
    for line in file:lines() do
        -- Convert to number
        local num = tonumber(line)
        if num then
            -- Add number to table
            table.insert(numbers, num)
        else
            -- If non-number found, clear table and stop
            numbers = {}
            break
        end
    end

    -- Close input file and return table
    file:close()
    return numbers
end

local function main()
    -- Input and output files
    local inputFile = "input.txt"
    local outputFile = "output.txt"

    -- Array (table non sorted)
    local array = getArray(inputFile)

    -- If table empty (empty file or error)
    if #array == 0 then
        print("No valid numbers to sort.")
        return
    end

    -- Get sorted, write to file
    local sorted = sort(array)
    writeToFile(sorted, outputFile)
end

-- Call main
main()
