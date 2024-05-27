// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import "@hotwired/turbo-rails"
// import "controllers"

const handleDynamicField = (e) => {
    e.preventDefault();

    const keyInput = document.createElement('input');
    keyInput.setAttribute('type', 'text');
    keyInput.setAttribute('placeholder', 'Enter Key');
    const selectInput = document.createElement('select');

// Define options for the select dropdown
    const options = ['Text', 'Number', 'Boolean', 'Date'];

// Create option elements and add them to the select dropdown
    options.forEach(option => {
        const optionElement = document.createElement('option');
        optionElement.textContent = option;
        selectInput.appendChild(optionElement);
    });
    const dynamicFieldInput = document.getElementById('collection_dynamic_field');
    const inputContainer = document.getElementById('dynamic-input-container');

    const divWrapper = document.createElement('div');
    divWrapper.appendChild(selectInput);
    divWrapper.appendChild(keyInput);
    divWrapper.style.display = 'flex'
    inputContainer.appendChild(divWrapper);

    // Add an event listener to handle adding key-value pairs on pressing Enter
    divWrapper.addEventListener('keydown', (event) => {
        if (event.key === 'Enter') {
            const value = keyInput.value.trim();
            const key = selectInput.value.trim();

            let dynamicData = JSON.parse(dynamicFieldInput.value || '[]');

            // Add key-value pair to the dynamic data array
            dynamicData.push({ [key]: value });

            // Update the value of the dynamic_field input with the updated JSON data
            dynamicFieldInput.value = JSON.stringify(dynamicData);

            const pairDisplay = document.createElement('div');
            pairDisplay.textContent = `${key}: ${value}`;

            // Append the pair display div to the container
            inputContainer.appendChild(pairDisplay);

            divWrapper.style.display = 'none';
            event.preventDefault();

        }
    });
};
document.addEventListener('DOMContentLoaded', () => {
    const choiceInput = document.getElementById('choice-input');
    const tagsSelect = document.getElementById('tags');
    const insertedValues = document.querySelector('.inserted-values');
    const hiddenInput = document.getElementById('tags-hidden-input');
    let tagsArray = [];

    const updateHiddenInput = () => {
        hiddenInput.value = JSON.stringify(tagsArray);
    };

    const addTag = (value) => {
        if (!tagsArray.includes(value)) {
            tagsArray.push(value);

            const newOption = document.createElement('option');
            newOption.value = value;
            newOption.text = value;
            newOption.selected = true;
            tagsSelect.add(newOption);

            const tagElement = createTagElement(value, newOption);
            insertedValues.appendChild(tagElement);

            updateHiddenInput();
        }
    };

    const createTagElement = (value, option) => {
        const tagElement = document.createElement('span');
        tagElement.className = 'tag';
        tagElement.textContent = value;

        const removeButton = document.createElement('span');
        removeButton.className = 'tag-remove';
        removeButton.textContent = '✖';
        removeButton.onclick = () => {
            option.selected = false;
            insertedValues.removeChild(tagElement);
            tagsArray = tagsArray.filter(tag => tag !== value);
            updateHiddenInput();
        };

        tagElement.appendChild(removeButton);
        return tagElement;
    };

    choiceInput?.addEventListener('keypress', (e) => {
        if (e.key === 'Enter') {
            e.preventDefault();
            const value = choiceInput.value.trim();
            if (value) {
                addTag(value);
                choiceInput.value = '';
            }
        }
    });

    tagsSelect?.addEventListener('change', () => {
        Array.from(tagsSelect.selectedOptions).forEach(option => {
            if (!tagsArray.includes(option.value)) {
                tagsArray.push(option.value);
                const tagElement = createTagElement(option.value, option);
                insertedValues.appendChild(tagElement);
                updateHiddenInput();
            }
        });
    });

    // Initial population of selected values
    if(tagsSelect){
        Array.from(tagsSelect.selectedOptions).forEach(option => {
            if (!tagsArray.includes(option.value)) {
                tagsArray.push(option.value);
                const tagElement = createTagElement(option.value, option);
                insertedValues.appendChild(tagElement);
            }
        });
        updateHiddenInput();
    }

});