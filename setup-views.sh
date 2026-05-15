#!/bin/bash

# Create directories
mkdir -p public/images
mkdir -p resources/views/layouts
mkdir -p resources/views/components
mkdir -p resources/views/customers
mkdir -p resources/views/services
mkdir -p resources/views/subscriptions

# public/images/logo.svg
cat > public/images/logo.svg << 'EOF'
<svg width="114" height="66" viewBox="0 0 114 66" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M26.8 12.3V3.79999H0V62.2H26.8V53.7C21.31 53.7 16.0448 51.519 12.1629 47.637C8.28088 43.755 6.1 38.49 6.1 33C6.1 27.51 8.28088 22.2448 12.1629 18.3629C16.0448 14.4809 21.31 12.3 26.8 12.3Z" fill="#394149"/>
<path d="M26.7969 12.3V53.7C32.2869 53.7 37.5521 51.519 41.4341 47.637C45.3161 43.755 47.4969 38.49 47.4969 33C47.4969 27.51 45.3161 22.2448 41.4341 18.3629C37.5521 14.4809 32.2869 12.3 26.7969 12.3Z" fill="#394149"/>
<path d="M59.4968 41.7273V24.2727H71.2582V27.3153H63.1872V31.4744H70.6531V34.517H63.1872V38.6846H71.2923V41.7273H59.4968Z" fill="#394149"/>
<path d="M74.1921 41.7273V24.2727H81.0785C82.3967 24.2727 83.5217 24.5085 84.4535 24.9801C85.391 25.446 86.1041 26.1079 86.5927 26.9659C87.087 27.8182 87.3342 28.821 87.3342 29.9744C87.3342 31.1335 87.0842 32.1307 86.5842 32.9659C86.0842 33.7954 85.3598 34.4318 84.4109 34.875C83.4677 35.3182 82.3257 35.5398 80.9848 35.5398H76.374V32.5738H80.3882C81.0927 32.5738 81.6779 32.4773 82.1438 32.2841C82.6098 32.0909 82.9563 31.8011 83.1836 31.4148C83.4166 31.0284 83.533 30.5483 83.533 29.9744C83.533 29.3949 83.4166 28.9062 83.1836 28.5085C82.9563 28.1108 82.6069 27.8096 82.1353 27.6051C81.6694 27.3949 81.0813 27.2898 80.3711 27.2898H77.8825V41.7273H74.1921ZM83.6183 33.7841L87.9563 41.7273H83.8825L79.6382 33.7841H83.6183Z" fill="#394149"/>
<path d="M89.9421 41.7273V24.2727H96.8285C98.1524 24.2727 99.2802 24.5255 100.212 25.0312C101.144 25.5312 101.854 26.2273 102.343 27.1193C102.837 28.0057 103.084 29.0284 103.084 30.1875C103.084 31.3466 102.834 32.3693 102.334 33.2557C101.834 34.142 101.11 34.8324 100.161 35.3267C99.2177 35.821 98.0757 36.0682 96.7348 36.0682H92.3455V33.1108H96.1382C96.8484 33.1108 97.4336 32.9886 97.8938 32.7443C98.3598 32.4943 98.7063 32.1505 98.9336 31.713C99.1666 31.2699 99.283 30.7613 99.283 30.1875C99.283 29.6079 99.1666 29.1023 98.9336 28.6704C98.7063 28.2329 98.3598 27.8949 97.8938 27.6562C97.4279 27.4119 96.837 27.2898 96.1211 27.2898H93.6325V41.7273H89.9421Z" fill="#394149"/>
</svg>
EOF

echo "Created: public/images/logo.svg"

# resources/views/layouts/app.blade.php
cat > resources/views/layouts/app.blade.php << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ERP Admin</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@500&display=swap" rel="stylesheet">
    @vite(['resources/css/app.css', 'resources/js/app.js'])
    <script src="https://code.iconify.design/3/3.1.0/iconify.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <style>
        .flatpickr-day.selected,
        .flatpickr-day.selected:hover {
            background: #394149;
            border-color: #394149;
        }

        @keyframes slideIn {
            from { transform: translateX(120%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        @keyframes slideOut {
            from { transform: translateX(0); opacity: 1; }
            to { transform: translateX(120%); opacity: 0; }
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 1050;
            overflow-x: hidden;
            overflow-y: auto;
            outline: 0;
        }

        .modal.show {
            display: block;
        }

        .modal-backdrop {
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1040;
            width: 100vw;
            height: 100vh;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .modal-backdrop.fade {
            opacity: 0;
        }

        .modal-backdrop.show {
            opacity: 0.5;
        }

        .modal-dialog {
            position: relative;
            width: auto;
            margin: 1.75rem auto;
            max-width: 500px;
            pointer-events: none;
        }

        .modal-dialog-centered {
            display: flex;
            align-items: center;
            min-height: calc(100% - 3.5rem);
        }

        .modal-content {
            position: relative;
            display: flex;
            flex-direction: column;
            width: 100%;
            pointer-events: auto;
        }

        .modal.fade .modal-dialog {
            transition: transform 0.3s ease-out;
            transform: translateY(-50px);
        }

        .modal.show .modal-dialog {
            transform: none;
        }
    </style>
</head>
<body class="font-sans antialiased text-[20px] leading-none tracking-normal" style="font-weight: 600;">
    <div class="flex min-h-screen">
        <x-sidebar :active="$active ?? ''" />
        <div class="flex-1 flex flex-col">
            <header class="bg-white border-b border-gray-200 pl-10 pr-8 py-6 flex justify-between items-center">
                <h1 class="font-semibold text-2xl text-gray-900 ml-4">@yield('title')</h1>
                @yield('header_action')
            </header>
            <main class="flex-1 bg-white p-8">
                @yield('content')
            </main>
        </div>
    </div>

    <div id="toast-container" style="position: fixed; top: 24px; right: 24px; z-index: 99999; display: flex; flex-direction: column; gap: 12px;"></div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function showToast(message, type = 'success') {
            const container = document.getElementById('toast-container');
            const toast = document.createElement('div');
            const bgColor = type === 'success' ? '#22c55e' : type === 'error' ? '#ef4444' : '#f97316';
            const icon = type === 'success' ? 'ic:baseline-check-circle' : type === 'error' ? 'ic:baseline-error' : 'ic:baseline-warning';

            toast.style.cssText = 'display:flex; align-items:center; gap:12px; background:white; border-left:4px solid ' + bgColor + '; border-radius:8px; padding:16px 20px; box-shadow:0 4px 12px rgba(0,0,0,0.15); min-width:300px; animation:slideIn 0.3s ease;';
            toast.innerHTML =
                '<span class="iconify" data-icon="' + icon + '" style="font-size:22px; color:' + bgColor + '; flex-shrink:0;"></span>' +
                '<span style="font-weight:600; color:#111827; flex:1;">' + message + '</span>' +
                '<button onclick="closeToast(this)" style="background:none; border:none; cursor:pointer; color:#9ca3af; font-size:18px; font-weight:bold; padding:0 0 0 12px; line-height:1;">×</button>';

            container.appendChild(toast);

            const timer = setTimeout(() => removeToast(toast), 3000);
            toast.dataset.timer = timer;
        }

        function closeToast(btn) {
            const toast = btn.parentElement;
            removeToast(toast);
        }

        function removeToast(toast) {
            if (toast._removing) return;
            toast._removing = true;
            clearTimeout(Number(toast.dataset.timer));
            toast.style.animation = 'slideOut 0.3s ease forwards';
            setTimeout(() => toast.remove(), 300);
        }
    </script>
    @stack('scripts')
</body>
</html>
EOF

echo "Created: resources/views/layouts/app.blade.php"

# resources/views/components/sidebar.blade.php
cat > resources/views/components/sidebar.blade.php << 'EOF'
@props(['active' => ''])

<aside id="sidebar" class="w-64 bg-white border-r border-gray-200 flex flex-col min-h-screen transition-all duration-300">
    <div class="px-4 py-4 flex items-center justify-between sidebar-header">
        <img src="/images/logo.svg" alt="ERP Logo" class="sidebar-logo h-20">
        <button id="sidebar-toggle" class="text-gray-400 hover:text-gray-600">
            <span class="iconify" data-icon="material-symbols:grid-layout-side-outline" style="font-size: 32px;"></span>
        </button>
    </div>

    <nav class="flex-1 px-4 mt-4 space-y-1">
        <a href="{{ route('customers.index') }}" class="flex items-center gap-3 px-4 py-2.5 rounded-lg {{ $active === 'customers' ? 'bg-gray-100 text-gray-900' : 'text-gray-700 hover:bg-gray-100' }}">
            <span class="iconify" data-icon="ic:baseline-people" style="font-size: 24px;"></span>
            <span class="sidebar-label">Customers</span>
        </a>
        <a href="{{ route('services.index') }}" class="flex items-center gap-3 px-4 py-2.5 rounded-lg {{ $active === 'services' ? 'bg-gray-100 text-gray-900' : 'text-gray-700 hover:bg-gray-100' }}">
            <span class="iconify" data-icon="mdi:cube" style="font-size: 24px;"></span>
            <span class="sidebar-label">Services</span>
        </a>
        <a href="{{ route('subscriptions.index') }}" class="flex items-center gap-3 px-4 py-2.5 rounded-lg {{ $active === 'subscriptions' ? 'bg-gray-100 text-gray-900' : 'text-gray-700 hover:bg-gray-100' }}">
            <span class="iconify" data-icon="material-symbols:note-rounded" style="font-size: 24px;"></span>
            <span class="sidebar-label">Subscription</span>
        </a>
    </nav>

</aside>

<script>
    document.addEventListener('DOMContentLoaded', () => {


        const sidebar = document.getElementById('sidebar');
        const toggle = document.getElementById('sidebar-toggle');

        toggle.addEventListener('click', () => {
            sidebar.classList.toggle('sidebar-collapsed');
            const header = sidebar.querySelector('.sidebar-header');
            header.classList.toggle('justify-between');
            header.classList.toggle('justify-center');
        });
    });
</script>
EOF

echo "Created: resources/views/components/sidebar.blade.php"


# resources/views/customers/index.blade.php
cat > resources/views/customers/index.blade.php << 'EOF'
@extends('layouts.app')

@section('title', 'Customers')

@section('content')
    <div class="flex justify-between items-center mb-6">
        <div></div>
        <button type="button" data-bs-toggle="modal" data-bs-target="#addDataModal" class="inline-flex items-center gap-2 bg-primary text-white rounded-xl px-6 py-4">
            <span class="iconify" data-icon="ic:baseline-add" style="font-size: 20px;"></span>
            Add Data
        </button>
    </div>

    <div class="border border-gray-200 rounded-lg bg-white" style="overflow: visible;">
    <table class="w-full text-left" style="overflow: visible;">
        <thead>
            <tr class="border-b border-gray-200">
                <th class="px-4 py-4 font-semibold text-gray-900">Customer ID</th>
                <th class="px-4 py-4 font-semibold text-gray-900">Customer Name</th>
                <th class="px-4 py-4 font-semibold text-gray-900">Email</th>
                <th class="px-4 py-4 font-semibold text-gray-900">Address</th>
                <th class="px-4 py-4 font-semibold text-gray-900">Status</th>
                <th class="px-4 py-4 font-semibold text-gray-900 text-center">Action</th>
            </tr>
        </thead>
        <tbody>
            @php
                $customers = [
                    ['id' => '021423457', 'name' => 'Alice Johnson', 'email' => 'alice@gmail.com', 'address' => 'Swan Street', 'status' => 'Active'],
                    ['id' => '021423458', 'name' => 'Bob Smith', 'email' => 'bob@gmail.com', 'address' => 'Maple Avenue', 'status' => 'Inactive'],
                    ['id' => '021423459', 'name' => 'Carol White', 'email' => 'carol@gmail.com', 'address' => 'Pine Road', 'status' => 'Active'],
                    ['id' => '021423460', 'name' => 'David Brown', 'email' => 'david@gmail.com', 'address' => 'Oak Lane', 'status' => 'Active'],
                    ['id' => '021423461', 'name' => 'Eve Davis', 'email' => 'eve@gmail.com', 'address' => 'Elm Drive', 'status' => 'Inactive'],
                    ['id' => '021423462', 'name' => 'Frank Miller', 'email' => 'frank@gmail.com', 'address' => 'Cedar Court', 'status' => 'Active'],
                ];
            @endphp
            @foreach ($customers as $customer)
                <tr class="border-b border-gray-200">
                    <td class="px-4 py-4 text-gray-900">{{ $customer['id'] }}</td>
                    <td class="px-4 py-4 text-gray-900">{{ $customer['name'] }}</td>
                    <td class="px-4 py-4 text-gray-900">{{ $customer['email'] }}</td>
                    <td class="px-4 py-4 text-gray-900">{{ $customer['address'] }}</td>
                    <td class="px-4 py-4">
                        <span class="inline-flex items-center px-3 py-0.5 rounded-full font-medium {{ $customer['status'] === 'Active' ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700' }}">
                            {{ $customer['status'] }}
                        </span>
                    </td>
                    <td class="px-4 py-4 text-center" style="position: relative; overflow: visible;">
                        <button class="flex justify-center w-full text-gray-500 hover:text-gray-700 action-toggle" data-status="{{ $customer['status'] }}">
                            <span class="iconify" data-icon="ic:baseline-menu" style="font-size: 24px;"></span>
                        </button>
                        <div class="action-dropdown" data-id="{{ $customer['id'] }}" data-name="{{ $customer['name'] }}" data-email="{{ $customer['email'] }}" data-address="{{ $customer['address'] }}" data-status="{{ $customer['status'] }}" style="display: none; position: absolute; right: 16px; top: 100%; background: white; border: 1px solid #e5e7eb; border-radius: 16px; box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1), 0 4px 6px -4px rgba(0,0,0,0.1); z-index: 9999; min-width: 200px; padding: 8px 0;">
                            <div style="display: flex; align-items: center; gap: 12px; padding: 12px 20px; cursor: pointer; font-weight: 600; color: #111827; white-space: nowrap;" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='transparent'">
                                <span class="iconify" data-icon="material-symbols:key" style="font-size: 22px;"></span>
                                <span>Active</span>
                            </div>
                            <div style="display: flex; align-items: center; gap: 12px; padding: 12px 20px; cursor: pointer; font-weight: 600; color: #111827; white-space: nowrap;" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='transparent'">
                                <span class="iconify" data-icon="material-symbols:key-off" style="font-size: 22px;"></span>
                                <span>Deactivate</span>
                            </div>
                            <div onclick="openEditModal(this)" style="display: flex; align-items: center; gap: 12px; padding: 12px 20px; cursor: pointer; font-weight: 600; color: #111827; white-space: nowrap;" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='transparent'">
                                <span class="iconify" data-icon="boxicons:edit" style="font-size: 22px;"></span>
                                <span>Edit</span>
                            </div>
                            <div onclick="openDeleteModal(this)" style="display: flex; align-items: center; gap: 12px; padding: 12px 20px; cursor: pointer; font-weight: 600; color: #ef4444; white-space: nowrap;" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='transparent'">
                                <span class="iconify" data-icon="material-symbols:delete" style="font-size: 22px;"></span>
                                <span>Delete</span>
                            </div>
                        </div>
                    </td>
                </tr>
            @endforeach
        </tbody>
    </table>
    </div>

    @include('customers.create')
    @include('customers.edit')
    @include('customers.delete')
@endsection

@push('scripts')
<script>
function toggleDropdown(el) {
    const options = el.nextElementSibling.nextElementSibling;
    const isVisible = options.style.display === 'block';

    document.querySelectorAll('.custom-dropdown-options').forEach(o => o.style.display = 'none');

    if (!isVisible) {
        const triggerRect = el.getBoundingClientRect();
        const spaceBelow = window.innerHeight - triggerRect.bottom;

        options.style.position = 'fixed';
        options.style.width = triggerRect.width + 'px';
        options.style.left = triggerRect.left + 'px';
        options.style.zIndex = '99999';
        options.style.display = 'block';

        if (spaceBelow < 120) {
            options.style.top = 'auto';
            options.style.bottom = (window.innerHeight - triggerRect.top + 4) + 'px';
        } else {
            options.style.bottom = 'auto';
            options.style.top = (triggerRect.bottom + 4) + 'px';
        }
    }
}

function selectOption(el, value, label) {
    const wrapper = el.closest('[style*="position: relative"]');
    const trigger = wrapper.querySelector('.custom-dropdown-trigger');
    const input = wrapper.querySelector('.custom-dropdown-value');
    const options = wrapper.querySelector('.custom-dropdown-options');
    trigger.textContent = label;
    trigger.style.color = '#111827';
    input.value = value;
    options.style.display = 'none';
}

document.addEventListener('click', function(e) {
    if (!e.target.closest('.custom-dropdown-trigger')) {
        document.querySelectorAll('.custom-dropdown-options').forEach(el => {
            el.style.display = 'none';
        });
    }
    if (!e.target.closest('.action-toggle') && !e.target.closest('.action-dropdown')) {
        document.querySelectorAll('.action-dropdown').forEach(el => {
            el.style.display = 'none';
        });
    }
});

document.querySelectorAll('.action-toggle').forEach(btn => {
    btn.addEventListener('click', function(e) {
        e.stopPropagation();
        const dropdown = this.nextElementSibling;
        const isOpen = dropdown.style.display === 'block';

        document.querySelectorAll('.action-dropdown').forEach(el => { el.style.display = 'none'; });

        if (!isOpen) {
            const btnRect = this.getBoundingClientRect();
            const spaceBelow = window.innerHeight - btnRect.bottom;

            if (spaceBelow < 300) {
                dropdown.style.top = 'auto';
                dropdown.style.bottom = '100%';
            } else {
                dropdown.style.bottom = 'auto';
                dropdown.style.top = '100%';
            }

            dropdown.style.display = 'block';
        }
    });
});

document.getElementById('addDataModal').addEventListener('hidden.bs.modal', function() {
    const modal = this;
    modal.querySelectorAll('input[type="text"], input[type="email"]').forEach(el => { el.value = ''; });
    modal.querySelectorAll('.custom-dropdown-value').forEach(el => { el.value = ''; });
    modal.querySelectorAll('.custom-dropdown-trigger').forEach(el => {
        el.style.color = '#6b7280';
        const placeholder = el.getAttribute('data-placeholder');
        if (placeholder) el.textContent = placeholder;
    });
});

function openEditModal(el) {
    const dropdown = el.closest('.action-dropdown');
    document.getElementById('edit_customer_id').value = dropdown.dataset.id;
    document.getElementById('edit_customer_name').value = dropdown.dataset.name;
    document.getElementById('edit_customer_email').value = dropdown.dataset.email;
    document.getElementById('edit_customer_address').value = dropdown.dataset.address;
    const status = dropdown.dataset.status;
    const statusInput = document.getElementById('edit_customer_status');
    statusInput.value = status.toLowerCase();
    const trigger = statusInput.nextElementSibling;
    trigger.textContent = status;
    trigger.style.color = '#111827';
    dropdown.style.display = 'none';
    new bootstrap.Modal(document.getElementById('editDataModal')).show();
}

function openDeleteModal(el) {
    const dropdown = el.closest('.action-dropdown');
    document.getElementById('delete_customer_name').textContent = dropdown.dataset.name;
    dropdown.style.display = 'none';
    new bootstrap.Modal(document.getElementById('deleteDataModal')).show();
}

function clearErrors(modal) {
    modal.querySelectorAll('.field-error').forEach(el => el.remove());
    modal.querySelectorAll('[style*="border: 1px solid #ef4444"]').forEach(el => {
        el.style.border = 'none';
    });
    modal.querySelectorAll('.custom-dropdown-trigger[style*="border: 1px solid #ef4444"]').forEach(el => {
        el.style.border = 'none';
    });
}

function showFieldError(field, message) {
    const existing = field.parentElement.querySelector('.field-error');
    if (existing) existing.remove();
    const err = document.createElement('div');
    err.className = 'field-error';
    err.style.cssText = 'color: #ef4444; font-size: 13px; margin-top: 4px;';
    err.textContent = message;
    field.style.border = '1px solid #ef4444';
    field.parentElement.appendChild(err);
}

function attachInputListeners(modal) {
    modal.querySelectorAll('input[type="text"], input[type="email"]').forEach(el => {
        el.addEventListener('input', function() {
            this.style.border = 'none';
            const err = this.parentElement.querySelector('.field-error');
            if (err) err.remove();
        }, { once: true });
    });
}

function validateAddCustomer(btn) {
    const modal = btn.closest('.modal');
    const form = modal.querySelector('form');
    clearErrors(modal);
    let valid = true;

    const inputs = form.querySelectorAll('input[type="text"], input[type="email"]');
    const nameInput = inputs[1];
    const emailInput = inputs[2];
    const addressInput = inputs[3];
    const statusInput = form.querySelector('.custom-dropdown-value');
    const statusTrigger = form.querySelector('.custom-dropdown-trigger');

    if (!nameInput.value.trim()) { showFieldError(nameInput, 'Customer Name is required'); valid = false; }
    if (!emailInput.value.trim()) { showFieldError(emailInput, 'Email is required'); valid = false; }
    else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(emailInput.value.trim())) { showFieldError(emailInput, 'Please enter a valid email'); valid = false; }
    if (!addressInput.value.trim()) { showFieldError(addressInput, 'Address is required'); valid = false; }
    if (!statusInput.value) { showFieldError(statusTrigger, 'Status is required'); valid = false; }

    if (!valid) { attachInputListeners(modal); return; }
    showToast('Data added successfully', 'success');
    bootstrap.Modal.getInstance(modal).hide();
}

function validateEditCustomer(btn) {
    const modal = btn.closest('.modal');
    const form = modal.querySelector('form');
    clearErrors(modal);
    let valid = true;

    const nameInput = document.getElementById('edit_customer_name');
    const emailInput = document.getElementById('edit_customer_email');
    const addressInput = document.getElementById('edit_customer_address');
    const statusInput = document.getElementById('edit_customer_status');
    const statusTrigger = statusInput.nextElementSibling;

    if (!nameInput.value.trim()) { showFieldError(nameInput, 'Customer Name is required'); valid = false; }
    if (!emailInput.value.trim()) { showFieldError(emailInput, 'Email is required'); valid = false; }
    else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(emailInput.value.trim())) { showFieldError(emailInput, 'Please enter a valid email'); valid = false; }
    if (!addressInput.value.trim()) { showFieldError(addressInput, 'Address is required'); valid = false; }
    if (!statusInput.value) { showFieldError(statusTrigger, 'Status is required'); valid = false; }

    if (!valid) { attachInputListeners(modal); return; }
    showToast('Data updated successfully', 'success');
    bootstrap.Modal.getInstance(modal).hide();
}
</script>
@endpush
EOF

echo "Created: resources/views/customers/index.blade.php"


# resources/views/customers/create.blade.php
cat > resources/views/customers/create.blade.php << 'EOF'
<div class="modal fade" id="addDataModal" tabindex="-1" aria-labelledby="addDataModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" style="max-width: 700px; width: 100%; overflow: visible;">
        <div class="modal-content bg-white rounded-xl p-8 shadow-lg border-0" style="overflow: visible;">
            <h2 class="text-2xl font-bold text-gray-900 text-center mb-6">Add Customer</h2>
            <form>
                <div class="mb-4">
                    <label class="block font-semibold text-gray-900 mb-2">Customer ID</label>
                    <input type="text" style="background-color: #f3f4f6; border: none; border-radius: 12px; padding: 12px 16px; width: 100%; outline: none;" placeholder="Enter your ID">
                </div>
                <div class="mb-4">
                    <label class="block font-semibold text-gray-900 mb-2">Customer Name</label>
                    <input type="text" style="background-color: #f3f4f6; border: none; border-radius: 12px; padding: 12px 16px; width: 100%; outline: none;" placeholder="Enter your name">
                </div>
                <div class="mb-4">
                    <label class="block font-semibold text-gray-900 mb-2">Email</label>
                    <input type="email" style="background-color: #f3f4f6; border: none; border-radius: 12px; padding: 12px 16px; width: 100%; outline: none;" placeholder="Enter your email">
                </div>
                <div class="mb-4">
                    <label class="block font-semibold text-gray-900 mb-2">Address</label>
                    <input type="text" style="background-color: #f3f4f6; border: none; border-radius: 12px; padding: 12px 16px; width: 100%; outline: none;" placeholder="Enter your address">
                </div>
                <div class="mb-6">
                    <label class="block font-semibold text-gray-900 mb-2">Status</label>
                    <div style="position: relative;">
                        <input type="hidden" name="status" class="custom-dropdown-value" value="">
                        <div class="custom-dropdown-trigger" data-placeholder="Select Status" onclick="toggleDropdown(this)" style="background-color: #f3f4f6; border: none; border-radius: 12px; padding: 12px 16px; width: 100%; outline: none; cursor: pointer; user-select: none; color: #6b7280; min-height: 48px;">
                            Select Status
                        </div>
                        <svg style="position: absolute; right: 16px; top: 50%; transform: translateY(-50%); pointer-events: none; width: 20px; height: 20px; color: #6b7280;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
                        </svg>
                        <div class="custom-dropdown-options" style="display: none; position: fixed; background: white; border: 1px solid #e5e7eb; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); z-index: 99999; max-height: 200px; overflow-y: auto;">
                            <div class="custom-dropdown-option" onclick="selectOption(this, 'active', 'Active')" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='white'" style="padding: 12px 16px; cursor: pointer;">Active</div>
                            <div class="custom-dropdown-option" onclick="selectOption(this, 'inactive', 'Inactive')" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='white'" style="padding: 12px 16px; cursor: pointer;">Inactive</div>
                        </div>
                    </div>
                </div>
                <div style="display: flex; align-items: center; justify-content: flex-end; gap: 12px;">
                    <button type="button" data-bs-dismiss="modal" style="padding: 12px 24px; border: 1px solid #d1d5db; border-radius: 12px; background: white; color: #111827;">
                        Cancel
                    </button>
                    <button type="button" onclick="validateAddCustomer(this)" style="padding: 12px 24px; border: none; border-radius: 12px; background-color: #394149; color: white;">
                        Submit
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
EOF

echo "Created: resources/views/customers/create.blade.php"

# resources/views/customers/edit.blade.php
cat > resources/views/customers/edit.blade.php << 'EOF'
<div class="modal fade" id="editDataModal" tabindex="-1" aria-labelledby="editDataModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" style="max-width: 700px; width: 100%; overflow: visible;">
        <div class="modal-content bg-white rounded-xl p-8 shadow-lg border-0" style="overflow: visible;">
            <h2 class="text-2xl font-bold text-gray-900 text-center mb-6">Edit Customer</h2>
            <form>
                <div class="mb-4">
                    <label class="block font-semibold text-gray-900 mb-2">Customer ID</label>
                    <input type="text" id="edit_customer_id" style="background-color: #f3f4f6; border: none; border-radius: 12px; padding: 12px 16px; width: 100%; outline: none;" placeholder="Enter your ID">
                </div>
                <div class="mb-4">
                    <label class="block font-semibold text-gray-900 mb-2">Customer Name</label>
                    <input type="text" id="edit_customer_name" style="background-color: #f3f4f6; border: none; border-radius: 12px; padding: 12px 16px; width: 100%; outline: none;" placeholder="Enter your name">
                </div>
                <div class="mb-4">
                    <label class="block font-semibold text-gray-900 mb-2">Email</label>
                    <input type="email" id="edit_customer_email" style="background-color: #f3f4f6; border: none; border-radius: 12px; padding: 12px 16px; width: 100%; outline: none;" placeholder="Enter your email">
                </div>
                <div class="mb-4">
                    <label class="block font-semibold text-gray-900 mb-2">Address</label>
                    <input type="text" id="edit_customer_address" style="background-color: #f3f4f6; border: none; border-radius: 12px; padding: 12px 16px; width: 100%; outline: none;" placeholder="Enter your address">
                </div>
                <div class="mb-6">
                    <label class="block font-semibold text-gray-900 mb-2">Status</label>
                    <div style="position: relative;">
                        <input type="hidden" name="status" id="edit_customer_status" class="custom-dropdown-value" value="">
                        <div class="custom-dropdown-trigger" data-placeholder="Select Status" onclick="toggleDropdown(this)" style="background-color: #f3f4f6; border: none; border-radius: 12px; padding: 12px 16px; width: 100%; outline: none; cursor: pointer; user-select: none; color: #6b7280; min-height: 48px;">
                            Select Status
                        </div>
                        <svg style="position: absolute; right: 16px; top: 50%; transform: translateY(-50%); pointer-events: none; width: 20px; height: 20px; color: #6b7280;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
                        </svg>
                        <div class="custom-dropdown-options" style="display: none; position: fixed; background: white; border: 1px solid #e5e7eb; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); z-index: 99999; max-height: 200px; overflow-y: auto;">
                            <div class="custom-dropdown-option" onclick="selectOption(this, 'active', 'Active')" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='white'" style="padding: 12px 16px; cursor: pointer;">Active</div>
                            <div class="custom-dropdown-option" onclick="selectOption(this, 'inactive', 'Inactive')" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='white'" style="padding: 12px 16px; cursor: pointer;">Inactive</div>
                        </div>
                    </div>
                </div>
                <div style="display: flex; align-items: center; justify-content: flex-end; gap: 12px;">
                    <button type="button" data-bs-dismiss="modal" style="padding: 12px 24px; border: 1px solid #d1d5db; border-radius: 12px; background: white; color: #111827;">
                        Cancel
                    </button>
                    <button type="button" onclick="validateEditCustomer(this)" style="padding: 12px 24px; border: none; border-radius: 12px; background-color: #394149; color: white;">
                        Submit
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
EOF

echo "Created: resources/views/customers/edit.blade.php"

# resources/views/customers/delete.blade.php
cat > resources/views/customers/delete.blade.php << 'EOF'
<div class="modal fade" id="deleteDataModal" tabindex="-1" aria-labelledby="deleteDataModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" style="max-width: 500px; width: 100%;">
        <div class="modal-content bg-white rounded-xl p-8 shadow-lg border-0 text-center">
            <div class="flex justify-center mb-4">
                <span class="iconify" data-icon="ion:warning-outline" style="font-size: 64px; color: #ef4444;"></span>
            </div>
            <h2 class="text-2xl font-bold text-gray-900 mb-4">Delete Data</h2>
            <p class="text-gray-700 mb-6">Are you sure you want to delete <span id="delete_customer_name" class="font-semibold"></span>?</p>
            <div style="display: flex; align-items: center; justify-content: center; gap: 12px;">
                <button type="button" data-bs-dismiss="modal" style="padding: 12px 24px; border: 1px solid #d1d5db; border-radius: 12px; background: white; color: #111827;">
                    Cancel
                </button>
                <button type="button" onclick="showToast('Data deleted successfully', 'success'); bootstrap.Modal.getInstance(this.closest('.modal')).hide();" style="padding: 12px 24px; border: none; border-radius: 12px; background-color: #ef4444; color: white;">
                    Delete
                </button>
            </div>
        </div>
    </div>
</div>
EOF

echo "Created: resources/views/customers/delete.blade.php"

# resources/views/customers/form.blade.php
cat > resources/views/customers/form.blade.php << 'EOF'
@extends('layouts.app')

@section('title', 'Add Customer')

@section('content')
    <div class="max-w-2xl mx-auto">
        <form>
            <div class="mb-4">
                <label class="block font-semibold text-gray-900 mb-2">Customer ID</label>
                <input type="text" style="background-color: #f3f4f6; border: none; border-radius: 12px; padding: 12px 16px; width: 100%; outline: none;" placeholder="Enter your ID">
            </div>
            <div class="mb-4">
                <label class="block font-semibold text-gray-900 mb-2">Customer Name</label>
                <input type="text" style="background-color: #f3f4f6; border: none; border-radius: 12px; padding: 12px 16px; width: 100%; outline: none;" placeholder="Enter your name">
            </div>
            <div class="mb-4">
                <label class="block font-semibold text-gray-900 mb-2">Email</label>
                <input type="email" style="background-color: #f3f4f6; border: none; border-radius: 12px; padding: 12px 16px; width: 100%; outline: none;" placeholder="Enter your email">
            </div>
            <div class="mb-4">
                <label class="block font-semibold text-gray-900 mb-2">Address</label>
                <input type="text" style="background-color: #f3f4f6; border: none; border-radius: 12px; padding: 12px 16px; width: 100%; outline: none;" placeholder="Enter your address">
            </div>
            <div class="mb-6">
                <label class="block font-semibold text-gray-900 mb-2">Status</label>
                <div style="position: relative;">
                    <input type="hidden" name="status" class="custom-dropdown-value" value="">
                    <div class="custom-dropdown-trigger" data-placeholder="Select Status" onclick="toggleDropdown(this)" style="background-color: #f3f4f6; border: none; border-radius: 12px; padding: 12px 16px; width: 100%; outline: none; cursor: pointer; user-select: none; color: #6b7280; min-height: 48px;">
                        Select Status
                    </div>
                    <svg style="position: absolute; right: 16px; top: 50%; transform: translateY(-50%); pointer-events: none; width: 20px; height: 20px; color: #6b7280;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
                    </svg>
                    <div class="custom-dropdown-options" style="display: none; position: fixed; background: white; border: 1px solid #e5e7eb; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); z-index: 99999; max-height: 200px; overflow-y: auto;">
                        <div class="custom-dropdown-option" onclick="selectOption(this, 'active', 'Active')" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='white'" style="padding: 12px 16px; cursor: pointer;">Active</div>
                        <div class="custom-dropdown-option" onclick="selectOption(this, 'inactive', 'Inactive')" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='white'" style="padding: 12px 16px; cursor: pointer;">Inactive</div>
                    </div>
                </div>
            </div>
            <div style="display: flex; align-items: center; justify-content: flex-end; gap: 12px;">
                <a href="{{ route('customers.index') }}" style="padding: 12px 24px; border: 1px solid #d1d5db; border-radius: 12px; background: white; color: #111827; text-decoration: none;">
                    Cancel
                </a>
                <button type="button" style="padding: 12px 24px; border: none; border-radius: 12px; background-color: #394149; color: white;">
                    Submit
                </button>
            </div>
        </form>
    </div>
@endsection
EOF

echo "Created: resources/views/customers/form.blade.php"


# resources/views/services/index.blade.php
cat > resources/views/services/index.blade.php << 'EOF'
@extends('layouts.app')

@section('title', 'Services')

@section('content')
    <div class="flex justify-between items-center mb-6">
        <div></div>
        <button type="button" data-bs-toggle="modal" data-bs-target="#addDataModal" class="inline-flex items-center gap-2 bg-primary text-white rounded-xl px-6 py-4">
            <span class="iconify" data-icon="ic:baseline-add" style="font-size: 20px;"></span>
            Add Data
        </button>
    </div>

    <div class="border border-gray-200 rounded-lg bg-white" style="overflow: visible;">
    <table class="w-full text-left" style="overflow: visible;">
        <thead>
            <tr class="border-b border-gray-200">
                <th class="px-4 py-4 font-semibold text-gray-900">Service Name</th>
                <th class="px-4 py-4 font-semibold text-gray-900">Price</th>
                <th class="px-4 py-4 font-semibold text-gray-900">Status</th>
                <th class="px-4 py-4 font-semibold text-gray-900 text-center">Action</th>
            </tr>
        </thead>
        <tbody>
            @php
                $services = [
                    ['name' => 'Service A', 'price' => 'Rp100,000,00', 'status' => 'Active'],
                    ['name' => 'Service B', 'price' => 'Rp250,000,00', 'status' => 'Active'],
                    ['name' => 'Service C', 'price' => 'Rp450,000,00', 'status' => 'Active'],
                    ['name' => 'Service D', 'price' => 'Rp150,000,00', 'status' => 'Inactive'],
                    ['name' => 'Service E', 'price' => 'Rp300,000,00', 'status' => 'Active'],
                    ['name' => 'Service F', 'price' => 'Rp200,000,00', 'status' => 'Inactive'],
                ];
            @endphp
            @foreach ($services as $service)
                <tr class="border-b border-gray-200">
                    <td class="px-4 py-4 text-gray-900">{{ $service['name'] }}</td>
                    <td class="px-4 py-4 text-gray-900">{{ $service['price'] }}</td>
                    <td class="px-4 py-4">
                        <span class="inline-flex items-center px-3 py-0.5 rounded-full font-medium {{ $service['status'] === 'Active' ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700' }}">
                            {{ $service['status'] }}
                        </span>
                    </td>
                    <td class="px-4 py-4 text-center" style="position: relative; overflow: visible;">
                        <button class="flex justify-center w-full text-gray-500 hover:text-gray-700 action-toggle" data-status="{{ $service['status'] }}">
                            <span class="iconify" data-icon="ic:baseline-menu" style="font-size: 24px;"></span>
                        </button>
                        <div class="action-dropdown" data-name="{{ $service['name'] }}" data-price="{{ $service['price'] }}" data-status="{{ $service['status'] }}" style="display: none; position: absolute; right: 16px; top: 100%; background: white; border: 1px solid #e5e7eb; border-radius: 16px; box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1), 0 4px 6px -4px rgba(0,0,0,0.1); z-index: 9999; min-width: 200px; padding: 8px 0;">
                            <div style="display: flex; align-items: center; gap: 12px; padding: 12px 20px; cursor: pointer; font-weight: 600; color: #111827; white-space: nowrap;" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='transparent'">
                                <span class="iconify" data-icon="material-symbols:key" style="font-size: 22px;"></span>
                                <span>Active</span>
                            </div>
                            <div style="display: flex; align-items: center; gap: 12px; padding: 12px 20px; cursor: pointer; font-weight: 600; color: #111827; white-space: nowrap;" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='transparent'">
                                <span class="iconify" data-icon="material-symbols:key-off" style="font-size: 22px;"></span>
                                <span>Deactivate</span>
                            </div>
                            <div onclick="openEditModal(this)" style="display: flex; align-items: center; gap: 12px; padding: 12px 20px; cursor: pointer; font-weight: 600; color: #111827; white-space: nowrap;" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='transparent'">
                                <span class="iconify" data-icon="boxicons:edit" style="font-size: 22px;"></span>
                                <span>Edit</span>
                            </div>
                            <div onclick="openDeleteModal(this)" style="display: flex; align-items: center; gap: 12px; padding: 12px 20px; cursor: pointer; font-weight: 600; color: #ef4444; white-space: nowrap;" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='transparent'">
                                <span class="iconify" data-icon="material-symbols:delete" style="font-size: 22px;"></span>
                                <span>Delete</span>
                            </div>
                        </div>
                    </td>
                </tr>
            @endforeach
        </tbody>
    </table>
    </div>

    @include('services.create')
    @include('services.edit')
    @include('services.delete')
@endsection

@push('scripts')
<script>
function toggleDropdown(el) {
    const options = el.nextElementSibling.nextElementSibling;
    const isVisible = options.style.display === 'block';

    document.querySelectorAll('.custom-dropdown-options').forEach(o => o.style.display = 'none');

    if (!isVisible) {
        const triggerRect = el.getBoundingClientRect();
        const spaceBelow = window.innerHeight - triggerRect.bottom;

        options.style.position = 'fixed';
        options.style.width = triggerRect.width + 'px';
        options.style.left = triggerRect.left + 'px';
        options.style.zIndex = '99999';
        options.style.display = 'block';

        if (spaceBelow < 120) {
            options.style.top = 'auto';
            options.style.bottom = (window.innerHeight - triggerRect.top + 4) + 'px';
        } else {
            options.style.bottom = 'auto';
            options.style.top = (triggerRect.bottom + 4) + 'px';
        }
    }
}

function selectOption(el, value, label) {
    const wrapper = el.closest('[style*="position: relative"]');
    const trigger = wrapper.querySelector('.custom-dropdown-trigger');
    const input = wrapper.querySelector('.custom-dropdown-value');
    const options = wrapper.querySelector('.custom-dropdown-options');
    trigger.textContent = label;
    trigger.style.color = '#111827';
    input.value = value;
    options.style.display = 'none';
}

document.addEventListener('click', function(e) {
    if (!e.target.closest('.custom-dropdown-trigger')) {
        document.querySelectorAll('.custom-dropdown-options').forEach(el => {
            el.style.display = 'none';
        });
    }
    if (!e.target.closest('.action-toggle') && !e.target.closest('.action-dropdown')) {
        document.querySelectorAll('.action-dropdown').forEach(el => {
            el.style.display = 'none';
        });
    }
});

document.querySelectorAll('.action-toggle').forEach(btn => {
    btn.addEventListener('click', function(e) {
        e.stopPropagation();
        const dropdown = this.nextElementSibling;
        const isOpen = dropdown.style.display === 'block';

        document.querySelectorAll('.action-dropdown').forEach(el => { el.style.display = 'none'; });

        if (!isOpen) {
            const btnRect = this.getBoundingClientRect();
            const spaceBelow = window.innerHeight - btnRect.bottom;

            if (spaceBelow < 300) {
                dropdown.style.top = 'auto';
                dropdown.style.bottom = '100%';
            } else {
                dropdown.style.bottom = 'auto';
                dropdown.style.top = '100%';
            }

            dropdown.style.display = 'block';
        }
    });
});

document.getElementById('addDataModal').addEventListener('hidden.bs.modal', function() {
    const modal = this;
    modal.querySelectorAll('input[type="text"], input[type="email"], textarea').forEach(el => { el.value = ''; });
    modal.querySelectorAll('.custom-dropdown-value').forEach(el => { el.value = ''; });
    modal.querySelectorAll('.custom-dropdown-trigger').forEach(el => {
        el.style.color = '#6b7280';
        const placeholder = el.getAttribute('data-placeholder');
        if (placeholder) el.textContent = placeholder;
    });
});

function openEditModal(el) {
    const dropdown = el.closest('.action-dropdown');
    document.getElementById('edit_service_name').value = dropdown.dataset.name;
    document.getElementById('edit_service_price').value = dropdown.dataset.price;
    document.getElementById('edit_service_description').value = '';
    const status = dropdown.dataset.status;
    const statusInput = document.getElementById('edit_service_status');
    statusInput.value = status.toLowerCase();
    const trigger = statusInput.nextElementSibling;
    trigger.textContent = status;
    trigger.style.color = '#111827';
    dropdown.style.display = 'none';
    new bootstrap.Modal(document.getElementById('editDataModal')).show();
}

function openDeleteModal(el) {
    const dropdown = el.closest('.action-dropdown');
    document.getElementById('delete_service_name').textContent = dropdown.dataset.name;
    dropdown.style.display = 'none';
    new bootstrap.Modal(document.getElementById('deleteDataModal')).show();
}

function clearErrors(modal) {
    modal.querySelectorAll('.field-error').forEach(el => el.remove());
    modal.querySelectorAll('[style*="border: 1px solid #ef4444"]').forEach(el => {
        el.style.border = 'none';
    });
    modal.querySelectorAll('.custom-dropdown-trigger[style*="border: 1px solid #ef4444"]').forEach(el => {
        el.style.border = 'none';
    });
}

function showFieldError(field, message) {
    const existing = field.parentElement.querySelector('.field-error');
    if (existing) existing.remove();
    const err = document.createElement('div');
    err.className = 'field-error';
    err.style.cssText = 'color: #ef4444; font-size: 13px; margin-top: 4px;';
    err.textContent = message;
    field.style.border = '1px solid #ef4444';
    field.parentElement.appendChild(err);
}

function attachInputListeners(modal) {
    modal.querySelectorAll('input[type="text"], textarea').forEach(el => {
        el.addEventListener('input', function() {
            this.style.border = 'none';
            const err = this.parentElement.querySelector('.field-error');
            if (err) err.remove();
        }, { once: true });
    });
}

function validateAddService(btn) {
    const modal = btn.closest('.modal');
    const form = modal.querySelector('form');
    clearErrors(modal);
    let valid = true;

    const inputs = form.querySelectorAll('input[type="text"]');
    const nameInput = inputs[0];
    const priceInput = inputs[1];
    const descInput = form.querySelector('textarea');
    const statusInput = form.querySelector('.custom-dropdown-value');
    const statusTrigger = form.querySelector('.custom-dropdown-trigger');

    if (!nameInput.value.trim()) { showFieldError(nameInput, 'Service Name is required'); valid = false; }
    if (!priceInput.value.trim()) { showFieldError(priceInput, 'Price is required'); valid = false; }
    else if (!/^\d+$/.test(priceInput.value.trim())) { showFieldError(priceInput, 'Price must be numeric'); valid = false; }
    if (!descInput.value.trim()) { showFieldError(descInput, 'Description is required'); valid = false; }
    if (!statusInput.value) { showFieldError(statusTrigger, 'Status is required'); valid = false; }

    if (!valid) { attachInputListeners(modal); return; }
    showToast('Data added successfully', 'success');
    bootstrap.Modal.getInstance(modal).hide();
}

function validateEditService(btn) {
    const modal = btn.closest('.modal');
    const form = modal.querySelector('form');
    clearErrors(modal);
    let valid = true;

    const nameInput = document.getElementById('edit_service_name');
    const priceInput = document.getElementById('edit_service_price');
    const descInput = document.getElementById('edit_service_description');
    const statusInput = document.getElementById('edit_service_status');
    const statusTrigger = statusInput.nextElementSibling;

    if (!nameInput.value.trim()) { showFieldError(nameInput, 'Service Name is required'); valid = false; }
    if (!priceInput.value.trim()) { showFieldError(priceInput, 'Price is required'); valid = false; }
    else if (!/^\d+$/.test(priceInput.value.trim())) { showFieldError(priceInput, 'Price must be numeric'); valid = false; }
    if (!descInput.value.trim()) { showFieldError(descInput, 'Description is required'); valid = false; }
    if (!statusInput.value) { showFieldError(statusTrigger, 'Status is required'); valid = false; }

    if (!valid) { attachInputListeners(modal); return; }
    showToast('Data updated successfully', 'success');
    bootstrap.Modal.getInstance(modal).hide();
}
</script>
@endpush
EOF

echo "Created: resources/views/services/index.blade.php"


# resources/views/services/create.blade.php
cat > resources/views/services/create.blade.php << 'EOF'
<div class="modal fade" id="addDataModal" tabindex="-1" aria-labelledby="addDataModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" style="max-width: 700px; width: 100%; overflow: visible;">
        <div class="modal-content bg-white rounded-xl p-8 shadow-lg border-0" style="overflow: visible;">
            <h2 class="text-2xl font-bold text-gray-900 text-center mb-6">Add Service</h2>
            <form>
                <div class="mb-4">
                    <label class="block font-semibold text-gray-900 mb-2">Service Name</label>
                    <input type="text" style="background-color: #f3f4f6; border: none; border-radius: 12px; padding: 12px 16px; width: 100%; outline: none;" placeholder="Enter service name">
                </div>
                <div class="mb-4">
                    <label class="block font-semibold text-gray-900 mb-2">Price</label>
                    <input type="text" style="background-color: #f3f4f6; border: none; border-radius: 12px; padding: 12px 16px; width: 100%; outline: none;" placeholder="Enter price">
                </div>
                <div class="mb-4">
                    <label class="block font-semibold text-gray-900 mb-2">Description</label>
                    <textarea rows="3" style="background-color: #f3f4f6; border: none; border-radius: 12px; padding: 12px 16px; width: 100%; outline: none; resize: none;" placeholder="Enter description"></textarea>
                </div>
                <div class="mb-6">
                    <label class="block font-semibold text-gray-900 mb-2">Status</label>
                    <div style="position: relative;">
                        <input type="hidden" name="status" class="custom-dropdown-value" value="">
                        <div class="custom-dropdown-trigger" data-placeholder="Select Status" onclick="toggleDropdown(this)" style="background-color: #f3f4f6; border: none; border-radius: 12px; padding: 12px 16px; width: 100%; outline: none; cursor: pointer; user-select: none; color: #6b7280; min-height: 48px;">
                            Select Status
                        </div>
                        <svg style="position: absolute; right: 16px; top: 50%; transform: translateY(-50%); pointer-events: none; width: 20px; height: 20px; color: #6b7280;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
                        </svg>
                        <div class="custom-dropdown-options" style="display: none; position: fixed; background: white; border: 1px solid #e5e7eb; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); z-index: 99999; max-height: 200px; overflow-y: auto;">
                            <div class="custom-dropdown-option" onclick="selectOption(this, 'active', 'Active')" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='white'" style="padding: 12px 16px; cursor: pointer;">Active</div>
                            <div class="custom-dropdown-option" onclick="selectOption(this, 'inactive', 'Inactive')" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='white'" style="padding: 12px 16px; cursor: pointer;">Inactive</div>
                        </div>
                    </div>
                </div>
                <div style="display: flex; align-items: center; justify-content: flex-end; gap: 12px;">
                    <button type="button" data-bs-dismiss="modal" style="padding: 12px 24px; border: 1px solid #d1d5db; border-radius: 12px; background: white; color: #111827;">
                        Cancel
                    </button>
                    <button type="button" onclick="validateAddService(this)" style="padding: 12px 24px; border: none; border-radius: 12px; background-color: #394149; color: white;">
                        Submit
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
EOF

echo "Created: resources/views/services/create.blade.php"

# resources/views/services/edit.blade.php
cat > resources/views/services/edit.blade.php << 'EOF'
<div class="modal fade" id="editDataModal" tabindex="-1" aria-labelledby="editDataModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" style="max-width: 700px; width: 100%; overflow: visible;">
        <div class="modal-content bg-white rounded-xl p-8 shadow-lg border-0" style="overflow: visible;">
            <h2 class="text-2xl font-bold text-gray-900 text-center mb-6">Edit Service</h2>
            <form>
                <div class="mb-4">
                    <label class="block font-semibold text-gray-900 mb-2">Service Name</label>
                    <input type="text" id="edit_service_name" style="background-color: #f3f4f6; border: none; border-radius: 12px; padding: 12px 16px; width: 100%; outline: none;" placeholder="Enter service name">
                </div>
                <div class="mb-4">
                    <label class="block font-semibold text-gray-900 mb-2">Price</label>
                    <input type="text" id="edit_service_price" style="background-color: #f3f4f6; border: none; border-radius: 12px; padding: 12px 16px; width: 100%; outline: none;" placeholder="Enter price">
                </div>
                <div class="mb-4">
                    <label class="block font-semibold text-gray-900 mb-2">Description</label>
                    <textarea rows="3" id="edit_service_description" style="background-color: #f3f4f6; border: none; border-radius: 12px; padding: 12px 16px; width: 100%; outline: none; resize: none;" placeholder="Enter description"></textarea>
                </div>
                <div class="mb-6">
                    <label class="block font-semibold text-gray-900 mb-2">Status</label>
                    <div style="position: relative;">
                        <input type="hidden" name="status" id="edit_service_status" class="custom-dropdown-value" value="">
                        <div class="custom-dropdown-trigger" data-placeholder="Select Status" onclick="toggleDropdown(this)" style="background-color: #f3f4f6; border: none; border-radius: 12px; padding: 12px 16px; width: 100%; outline: none; cursor: pointer; user-select: none; color: #6b7280; min-height: 48px;">
                            Select Status
                        </div>
                        <svg style="position: absolute; right: 16px; top: 50%; transform: translateY(-50%); pointer-events: none; width: 20px; height: 20px; color: #6b7280;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
                        </svg>
                        <div class="custom-dropdown-options" style="display: none; position: fixed; background: white; border: 1px solid #e5e7eb; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); z-index: 99999; max-height: 200px; overflow-y: auto;">
                            <div class="custom-dropdown-option" onclick="selectOption(this, 'active', 'Active')" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='white'" style="padding: 12px 16px; cursor: pointer;">Active</div>
                            <div class="custom-dropdown-option" onclick="selectOption(this, 'inactive', 'Inactive')" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='white'" style="padding: 12px 16px; cursor: pointer;">Inactive</div>
                        </div>
                    </div>
                </div>
                <div style="display: flex; align-items: center; justify-content: flex-end; gap: 12px;">
                    <button type="button" data-bs-dismiss="modal" style="padding: 12px 24px; border: 1px solid #d1d5db; border-radius: 12px; background: white; color: #111827;">
                        Cancel
                    </button>
                    <button type="button" onclick="validateEditService(this)" style="padding: 12px 24px; border: none; border-radius: 12px; background-color: #394149; color: white;">
                        Submit
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
EOF

echo "Created: resources/views/services/edit.blade.php"

# resources/views/services/delete.blade.php
cat > resources/views/services/delete.blade.php << 'EOF'
<div class="modal fade" id="deleteDataModal" tabindex="-1" aria-labelledby="deleteDataModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" style="max-width: 500px; width: 100%;">
        <div class="modal-content bg-white rounded-xl p-8 shadow-lg border-0 text-center">
            <div class="flex justify-center mb-4">
                <span class="iconify" data-icon="ion:warning-outline" style="font-size: 64px; color: #ef4444;"></span>
            </div>
            <h2 class="text-2xl font-bold text-gray-900 mb-4">Delete Data</h2>
            <p class="text-gray-700 mb-6">Are you sure you want to delete <span id="delete_service_name" class="font-semibold"></span>?</p>
            <div style="display: flex; align-items: center; justify-content: center; gap: 12px;">
                <button type="button" data-bs-dismiss="modal" style="padding: 12px 24px; border: 1px solid #d1d5db; border-radius: 12px; background: white; color: #111827;">
                    Cancel
                </button>
                <button type="button" onclick="showToast('Data deleted successfully', 'success'); bootstrap.Modal.getInstance(this.closest('.modal')).hide();" style="padding: 12px 24px; border: none; border-radius: 12px; background-color: #ef4444; color: white;">
                    Delete
                </button>
            </div>
        </div>
    </div>
</div>
EOF

echo "Created: resources/views/services/delete.blade.php"

# resources/views/services/form.blade.php
cat > resources/views/services/form.blade.php << 'EOF'
@extends('layouts.app')

@section('title', 'Add Service')

@section('content')
    <div class="max-w-2xl mx-auto">
        <form>
            <div class="mb-4">
                <label class="block font-semibold text-gray-900 mb-2">Service Name</label>
                <input type="text" style="background-color: #f3f4f6; border: none; border-radius: 12px; padding: 12px 16px; width: 100%; outline: none;" placeholder="Enter service name">
            </div>
            <div class="mb-4">
                <label class="block font-semibold text-gray-900 mb-2">Price</label>
                <input type="text" style="background-color: #f3f4f6; border: none; border-radius: 12px; padding: 12px 16px; width: 100%; outline: none;" placeholder="Enter price">
            </div>
            <div class="mb-4">
                <label class="block font-semibold text-gray-900 mb-2">Description</label>
                <textarea rows="3" style="background-color: #f3f4f6; border: none; border-radius: 12px; padding: 12px 16px; width: 100%; outline: none; resize: none;" placeholder="Enter description"></textarea>
            </div>
            <div class="mb-6">
                <label class="block font-semibold text-gray-900 mb-2">Status</label>
                <div style="position: relative;">
                    <input type="hidden" name="status" class="custom-dropdown-value" value="">
                    <div class="custom-dropdown-trigger" data-placeholder="Select Status" onclick="toggleDropdown(this)" style="background-color: #f3f4f6; border: none; border-radius: 12px; padding: 12px 16px; width: 100%; outline: none; cursor: pointer; user-select: none; color: #6b7280; min-height: 48px;">
                        Select Status
                    </div>
                    <svg style="position: absolute; right: 16px; top: 50%; transform: translateY(-50%); pointer-events: none; width: 20px; height: 20px; color: #6b7280;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
                    </svg>
                    <div class="custom-dropdown-options" style="display: none; position: fixed; background: white; border: 1px solid #e5e7eb; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); z-index: 99999; max-height: 200px; overflow-y: auto;">
                        <div class="custom-dropdown-option" onclick="selectOption(this, 'active', 'Active')" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='white'" style="padding: 12px 16px; cursor: pointer;">Active</div>
                        <div class="custom-dropdown-option" onclick="selectOption(this, 'inactive', 'Inactive')" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='white'" style="padding: 12px 16px; cursor: pointer;">Inactive</div>
                    </div>
                </div>
            </div>
            <div style="display: flex; align-items: center; justify-content: flex-end; gap: 12px;">
                <a href="{{ route('services.index') }}" style="padding: 12px 24px; border: 1px solid #d1d5db; border-radius: 12px; background: white; color: #111827; text-decoration: none;">
                    Cancel
                </a>
                <button type="button" style="padding: 12px 24px; border: none; border-radius: 12px; background-color: #394149; color: white;">
                    Submit
                </button>
            </div>
        </form>
    </div>
@endsection
EOF

echo "Created: resources/views/services/form.blade.php"


# resources/views/subscriptions/index.blade.php
cat > resources/views/subscriptions/index.blade.php << 'EOF'
@extends('layouts.app')

@section('title', 'Subscriptions')

@section('content')
    <div class="flex justify-between items-center mb-6">
        <div></div>
        <button type="button" data-bs-toggle="modal" data-bs-target="#addDataModal" class="inline-flex items-center gap-2 bg-primary text-white rounded-xl px-6 py-4">
            <span class="iconify" data-icon="ic:baseline-add" style="font-size: 20px;"></span>
            Add Data
        </button>
    </div>

    <div class="border border-gray-200 rounded-lg bg-white" style="overflow: visible;">
    <table class="w-full text-left" style="overflow: visible;">
        <thead>
            <tr class="border-b border-gray-200">
                <th class="px-4 py-4 font-semibold text-gray-900">Customer Name</th>
                <th class="px-4 py-4 font-semibold text-gray-900">Services</th>
                <th class="px-4 py-4 font-semibold text-gray-900">Services Period</th>
                <th class="px-4 py-4 font-semibold text-gray-900">Status</th>
                <th class="px-4 py-4 font-semibold text-gray-900 text-center">Action</th>
            </tr>
        </thead>
        <tbody>
            @php
                $subscriptions = [
                    ['customer' => 'Alice Johnson', 'service' => 'Service A', 'period' => '1 Jan 2026 - 1 Jan 2027', 'status' => 'Active'],
                    ['customer' => 'Bob Smith', 'service' => 'Service B', 'period' => '15 Feb 2026 - 15 Feb 2027', 'status' => 'Trial'],
                    ['customer' => 'Carol White', 'service' => 'Service C', 'period' => '10 Mar 2026 - 10 Mar 2027', 'status' => 'Isolir'],
                    ['customer' => 'David Brown', 'service' => 'Service A', 'period' => '5 Apr 2026 - 5 Apr 2027', 'status' => 'Dismantle'],
                    ['customer' => 'Eve Davis', 'service' => 'Service B', 'period' => '20 May 2026 - 20 May 2027', 'status' => 'Active'],
                    ['customer' => 'Frank Miller', 'service' => 'Service C', 'period' => '1 Jun 2026 - 1 Jun 2027', 'status' => 'Trial'],
                ];
            @endphp
            @foreach ($subscriptions as $subscription)
                <tr class="border-b border-gray-200">
                    <td class="px-4 py-4 text-gray-900">{{ $subscription['customer'] }}</td>
                    <td class="px-4 py-4 text-gray-900">{{ $subscription['service'] }}</td>
                    <td class="px-4 py-4 text-gray-900">{{ $subscription['period'] }}</td>
                    <td class="px-4 py-4">
                        @php
                            $statusClasses = match($subscription['status']) {
                                'Active' => 'bg-green-100 text-green-700',
                                'Trial' => 'bg-yellow-100 text-yellow-700',
                                'Isolir' => 'bg-red-100 text-red-700',
                                'Dismantle' => 'bg-gray-100 text-gray-700',
                                default => 'bg-gray-100 text-gray-700',
                            };
                        @endphp
                        <span class="inline-flex items-center px-3 py-0.5 rounded-full font-medium {{ $statusClasses }}">
                            {{ $subscription['status'] }}
                        </span>
                    </td>
                    <td class="px-4 py-4 text-center" style="position: relative;">
                        <button class="flex justify-center w-full text-gray-500 hover:text-gray-700 action-toggle">
                            <span class="iconify" data-icon="ic:baseline-menu" style="font-size: 24px;"></span>
                        </button>
                        <div class="action-dropdown" style="display: none; position: absolute; right: 16px; top: 100%; background: white; border: 1px solid #e5e7eb; border-radius: 16px; box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1), 0 4px 6px -4px rgba(0,0,0,0.1); z-index: 9999; min-width: 260px; padding: 8px 0;">
                            <div style="display: flex; align-items: center; gap: 12px; padding: 12px 20px; cursor: pointer; font-weight: 600; color: #111827; white-space: nowrap;" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='transparent'">
                                <span class="iconify" data-icon="material-symbols:key" style="font-size: 22px;"></span>
                                <span>Active</span>
                            </div>
                            <div style="display: flex; align-items: center; gap: 12px; padding: 12px 20px; cursor: pointer; font-weight: 600; color: #111827; white-space: nowrap;" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='transparent'">
                                <span class="iconify" data-icon="material-symbols:key-off" style="font-size: 22px;"></span>
                                <span>Deactivate</span>
                            </div>
                            <div style="display: flex; align-items: center; gap: 12px; padding: 12px 20px; cursor: pointer; font-weight: 600; color: #111827; white-space: nowrap;" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='transparent'">
                                <span class="iconify" data-icon="material-symbols:hourglass-top" style="font-size: 22px;"></span>
                                <span>Trial</span>
                            </div>
                            <div style="display: flex; align-items: center; gap: 12px; padding: 12px 20px; cursor: pointer; font-weight: 600; color: #111827; white-space: nowrap;" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='transparent'">
                                <span class="iconify" data-icon="material-symbols:stop-circle-outline-rounded" style="font-size: 22px;"></span>
                                <span>Isolir</span>
                            </div>
                            <div style="display: flex; align-items: center; gap: 12px; padding: 12px 20px; cursor: pointer; font-weight: 600; color: #111827; white-space: nowrap;" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='transparent'">
                                <span class="iconify" data-icon="material-symbols:dangerous" style="font-size: 22px;"></span>
                                <span>Dismantle</span>
                            </div>
                        </div>
                    </td>
                </tr>
            @endforeach
        </tbody>
    </table>
    </div>

    <div class="modal fade" id="addDataModal" tabindex="-1" aria-labelledby="addDataModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" style="max-width: 700px; width: 100%; overflow: visible;">
            <div class="modal-content bg-white rounded-xl p-8 shadow-lg border-0" style="overflow: visible;">
                <h2 class="text-2xl font-bold text-gray-900 text-center mb-6">Add Subscription</h2>
                @include('subscriptions.form')
            </div>
        </div>
    </div>
@endsection

@push('scripts')
<script>
function toggleDropdown(el) {
    const options = el.nextElementSibling.nextElementSibling;
    const isVisible = options.style.display === 'block';

    document.querySelectorAll('.custom-dropdown-options').forEach(o => o.style.display = 'none');

    if (!isVisible) {
        const triggerRect = el.getBoundingClientRect();
        const spaceBelow = window.innerHeight - triggerRect.bottom;

        options.style.position = 'fixed';
        options.style.width = triggerRect.width + 'px';
        options.style.left = triggerRect.left + 'px';
        options.style.zIndex = '99999';
        options.style.display = 'block';

        if (spaceBelow < 250) {
            options.style.top = 'auto';
            options.style.bottom = (window.innerHeight - triggerRect.top + 4) + 'px';
        } else {
            options.style.bottom = 'auto';
            options.style.top = (triggerRect.bottom + 4) + 'px';
        }
    }
}

function selectOption(el, value, label) {
    const wrapper = el.closest('[style*="position: relative"]');
    const trigger = wrapper.querySelector('.custom-dropdown-trigger');
    const input = wrapper.querySelector('.custom-dropdown-value');
    const options = wrapper.querySelector('.custom-dropdown-options');
    trigger.textContent = label;
    trigger.style.color = '#111827';
    input.value = value;
    options.style.display = 'none';
}

document.addEventListener('click', function(e) {
    if (!e.target.closest('.custom-dropdown-trigger')) {
        document.querySelectorAll('.custom-dropdown-options').forEach(el => {
            el.style.display = 'none';
        });
    }
    if (!e.target.closest('.action-toggle') && !e.target.closest('.action-dropdown')) {
        document.querySelectorAll('.action-dropdown').forEach(el => {
            el.style.display = 'none';
        });
    }
});

document.querySelectorAll('.action-toggle').forEach(btn => {
    btn.addEventListener('click', function(e) {
        e.stopPropagation();
        const dropdown = this.nextElementSibling;
        const isOpen = dropdown.style.display === 'block';

        document.querySelectorAll('.action-dropdown').forEach(el => { el.style.display = 'none'; });

        if (!isOpen) {
            const btnRect = this.getBoundingClientRect();
            const spaceBelow = window.innerHeight - btnRect.bottom;

            if (spaceBelow < 300) {
                dropdown.style.top = 'auto';
                dropdown.style.bottom = '100%';
            } else {
                dropdown.style.bottom = 'auto';
                dropdown.style.top = '100%';
            }

            dropdown.style.display = 'block';
        }
    });
});

document.addEventListener('DOMContentLoaded', function() {
    const modal = document.getElementById('addDataModal');

    modal.addEventListener('show.bs.modal', function() {
        const startInput = document.getElementById('start_date');
        const endInput = document.getElementById('end_date');

        if (startInput._flatpickr) startInput._flatpickr.destroy();
        if (endInput._flatpickr) endInput._flatpickr.destroy();

        document.querySelectorAll('.flatpickr-calendar').forEach(el => el.remove());

        flatpickr(startInput, { dateFormat: 'd/m/Y', appendTo: modal });
        flatpickr(endInput, { dateFormat: 'd/m/Y', appendTo: modal });
    });

    modal.addEventListener('hidden.bs.modal', function() {
        const startInput = document.getElementById('start_date');
        const endInput = document.getElementById('end_date');

        if (startInput._flatpickr) startInput._flatpickr.destroy();
        if (endInput._flatpickr) endInput._flatpickr.destroy();

        document.querySelectorAll('.flatpickr-calendar').forEach(el => el.remove());

        startInput.value = '';
        endInput.value = '';

        modal.querySelectorAll('input[type="text"], input[type="email"]').forEach(el => el.value = '');
        modal.querySelectorAll('.custom-dropdown-value').forEach(el => el.value = '');
        modal.querySelectorAll('.custom-dropdown-trigger').forEach(el => {
            el.style.color = '#6b7280';
            const placeholder = el.getAttribute('data-placeholder');
            if (placeholder) el.textContent = placeholder;
        });
    });
});

function clearErrors(modal) {
    modal.querySelectorAll('.field-error').forEach(el => el.remove());
    modal.querySelectorAll('[style*="border: 1px solid #ef4444"]').forEach(el => {
        el.style.border = 'none';
    });
    modal.querySelectorAll('.custom-dropdown-trigger[style*="border: 1px solid #ef4444"]').forEach(el => {
        el.style.border = 'none';
    });
}

function showFieldError(field, message) {
    const existing = field.parentElement.querySelector('.field-error');
    if (existing) existing.remove();
    const err = document.createElement('div');
    err.className = 'field-error';
    err.style.cssText = 'color: #ef4444; font-size: 13px; margin-top: 4px;';
    err.textContent = message;
    field.style.border = '1px solid #ef4444';
    field.parentElement.appendChild(err);
}

function attachInputListeners(modal) {
    modal.querySelectorAll('input[type="text"]').forEach(el => {
        el.addEventListener('input', function() {
            this.style.border = 'none';
            const err = this.parentElement.querySelector('.field-error');
            if (err) err.remove();
        }, { once: true });
    });
}

function parseDate(str) {
    if (!str) return null;
    const parts = str.split('/');
    return new Date(parts[2], parts[1] - 1, parts[0]);
}

function validateAddSubscription(btn) {
    const modal = btn.closest('.modal');
    const form = modal.querySelector('form');
    clearErrors(modal);
    let valid = true;

    const dropdowns = form.querySelectorAll('.custom-dropdown-value');
    const customerInput = dropdowns[0];
    const serviceInput = dropdowns[1];
    const statusInput = dropdowns[2];
    const customerTrigger = customerInput.nextElementSibling;
    const serviceTrigger = serviceInput.nextElementSibling;
    const statusTrigger = statusInput.nextElementSibling;

    const startInput = document.getElementById('start_date');
    const endInput = document.getElementById('end_date');

    if (!customerInput.value) { showFieldError(customerTrigger, 'Customer is required'); valid = false; }
    if (!serviceInput.value) { showFieldError(serviceTrigger, 'Service is required'); valid = false; }
    if (!startInput.value.trim()) { showFieldError(startInput, 'Start Date is required'); valid = false; }
    if (!endInput.value.trim()) { showFieldError(endInput, 'End Date is required'); valid = false; }
    else if (startInput.value.trim()) {
        const start = parseDate(startInput.value.trim());
        const end = parseDate(endInput.value.trim());
        if (start && end && end <= start) { showFieldError(endInput, 'End Date must be after Start Date'); valid = false; }
    }
    if (!statusInput.value) { showFieldError(statusTrigger, 'Status is required'); valid = false; }

    if (!valid) { attachInputListeners(modal); return; }
    showToast('Data added successfully', 'success');
    bootstrap.Modal.getInstance(modal).hide();
}
</script>
@endpush
EOF

echo "Created: resources/views/subscriptions/index.blade.php"


# resources/views/subscriptions/form.blade.php
cat > resources/views/subscriptions/form.blade.php << 'EOF'
<form>
    <div class="mb-4">
        <label class="block font-semibold text-gray-900 mb-2">Customer</label>
        <div style="position: relative;">
            <input type="hidden" name="customer" class="custom-dropdown-value" value="">
            <div class="custom-dropdown-trigger" data-placeholder="Select customer" onclick="toggleDropdown(this)" style="background-color: #f3f4f6; border: none; border-radius: 12px; padding: 12px 16px; width: 100%; outline: none; cursor: pointer; user-select: none; color: #6b7280; min-height: 48px;">
                Select customer
            </div>
            <svg style="position: absolute; right: 16px; top: 50%; transform: translateY(-50%); pointer-events: none; width: 20px; height: 20px; color: #6b7280;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
            </svg>
            <div class="custom-dropdown-options" style="display: none; position: fixed; background: white; border: 1px solid #e5e7eb; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); z-index: 99999; max-height: 200px; overflow-y: auto;">
                <div class="custom-dropdown-option" onclick="selectOption(this, '1', 'Alice Johnson')" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='white'" style="padding: 12px 16px; cursor: pointer;">Alice Johnson</div>
                <div class="custom-dropdown-option" onclick="selectOption(this, '2', 'Bob Smith')" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='white'" style="padding: 12px 16px; cursor: pointer;">Bob Smith</div>
                <div class="custom-dropdown-option" onclick="selectOption(this, '3', 'Carol White')" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='white'" style="padding: 12px 16px; cursor: pointer;">Carol White</div>
                <div class="custom-dropdown-option" onclick="selectOption(this, '4', 'David Brown')" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='white'" style="padding: 12px 16px; cursor: pointer;">David Brown</div>
                <div class="custom-dropdown-option" onclick="selectOption(this, '5', 'Eve Davis')" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='white'" style="padding: 12px 16px; cursor: pointer;">Eve Davis</div>
            </div>
        </div>
    </div>
    <div class="mb-4">
        <label class="block font-semibold text-gray-900 mb-2">Service</label>
        <div style="position: relative;">
            <input type="hidden" name="service" class="custom-dropdown-value" value="">
            <div class="custom-dropdown-trigger" data-placeholder="Select service" onclick="toggleDropdown(this)" style="background-color: #f3f4f6; border: none; border-radius: 12px; padding: 12px 16px; width: 100%; outline: none; cursor: pointer; user-select: none; color: #6b7280; min-height: 48px;">
                Select service
            </div>
            <svg style="position: absolute; right: 16px; top: 50%; transform: translateY(-50%); pointer-events: none; width: 20px; height: 20px; color: #6b7280;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
            </svg>
            <div class="custom-dropdown-options" style="display: none; position: fixed; background: white; border: 1px solid #e5e7eb; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); z-index: 99999; max-height: 200px; overflow-y: auto;">
                <div class="custom-dropdown-option" onclick="selectOption(this, '1', 'Service A')" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='white'" style="padding: 12px 16px; cursor: pointer;">Service A</div>
                <div class="custom-dropdown-option" onclick="selectOption(this, '2', 'Service B')" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='white'" style="padding: 12px 16px; cursor: pointer;">Service B</div>
                <div class="custom-dropdown-option" onclick="selectOption(this, '3', 'Service C')" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='white'" style="padding: 12px 16px; cursor: pointer;">Service C</div>
                <div class="custom-dropdown-option" onclick="selectOption(this, '4', 'Service D')" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='white'" style="padding: 12px 16px; cursor: pointer;">Service D</div>
                <div class="custom-dropdown-option" onclick="selectOption(this, '5', 'Service E')" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='white'" style="padding: 12px 16px; cursor: pointer;">Service E</div>
            </div>
        </div>
    </div>
    <div class="mb-4">
        <label class="block font-semibold text-gray-900 mb-2">Start Date</label>
        <div style="position: relative;">
            <input type="text" id="start_date" name="start_date" style="background-color: #f3f4f6; border: none; border-radius: 12px; padding: 12px 16px; width: 100%; outline: none;" placeholder="Select start date" readonly>
            <span class="iconify" data-icon="ic:baseline-calendar-today" style="position: absolute; right: 16px; top: 50%; transform: translateY(-50%); pointer-events: none; font-size: 20px; color: #6b7280;"></span>
        </div>
    </div>
    <div class="mb-4">
        <label class="block font-semibold text-gray-900 mb-2">End Date</label>
        <div style="position: relative;">
            <input type="text" id="end_date" name="end_date" style="background-color: #f3f4f6; border: none; border-radius: 12px; padding: 12px 16px; width: 100%; outline: none;" placeholder="Select end date" readonly>
            <span class="iconify" data-icon="ic:baseline-calendar-today" style="position: absolute; right: 16px; top: 50%; transform: translateY(-50%); pointer-events: none; font-size: 20px; color: #6b7280;"></span>
        </div>
    </div>
    <div class="mb-6">
        <label class="block font-semibold text-gray-900 mb-2">Status</label>
        <div style="position: relative;">
            <input type="hidden" name="status" class="custom-dropdown-value" value="">
            <div class="custom-dropdown-trigger" data-placeholder="Select Status" onclick="toggleDropdown(this)" style="background-color: #f3f4f6; border: none; border-radius: 12px; padding: 12px 16px; width: 100%; outline: none; cursor: pointer; user-select: none; color: #6b7280; min-height: 48px;">
                Select Status
            </div>
            <svg style="position: absolute; right: 16px; top: 50%; transform: translateY(-50%); pointer-events: none; width: 20px; height: 20px; color: #6b7280;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
            </svg>
            <div class="custom-dropdown-options" style="display: none; position: fixed; background: white; border: 1px solid #e5e7eb; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); z-index: 99999; max-height: 200px; overflow-y: auto;">
                <div class="custom-dropdown-option" onclick="selectOption(this, 'active', 'Active')" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='white'" style="padding: 12px 16px; cursor: pointer;">Active</div>
                <div class="custom-dropdown-option" onclick="selectOption(this, 'trial', 'Trial')" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='white'" style="padding: 12px 16px; cursor: pointer;">Trial</div>
                <div class="custom-dropdown-option" onclick="selectOption(this, 'isolir', 'Isolir')" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='white'" style="padding: 12px 16px; cursor: pointer;">Isolir</div>
                <div class="custom-dropdown-option" onclick="selectOption(this, 'dismantle', 'Dismantle')" onmouseenter="this.style.backgroundColor='#f3f4f6'" onmouseleave="this.style.backgroundColor='white'" style="padding: 12px 16px; cursor: pointer;">Dismantle</div>
            </div>
        </div>
    </div>
    <div style="display: flex; align-items: center; justify-content: flex-end; gap: 12px;">
        <button type="button" data-bs-dismiss="modal" style="padding: 12px 24px; border: 1px solid #d1d5db; border-radius: 12px; background: white; color: #111827;">
            Cancel
        </button>
        <button type="button" onclick="validateAddSubscription(this)" style="padding: 12px 24px; border: none; border-radius: 12px; background-color: #394149; color: white;">
            Submit
        </button>
    </div>
</form>
EOF

echo "Created: resources/views/subscriptions/form.blade.php"

# routes/web.php
cat > routes/web.php << 'EOF'
<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/customers', fn () => view('customers.index', ['active' => 'customers']))->name('customers.index');
Route::get('/customers/create', fn () => view('customers.form', ['active' => 'customers']))->name('customers.create');

Route::get('/services', fn () => view('services.index', ['active' => 'services']))->name('services.index');
Route::get('/services/create', fn () => view('services.form', ['active' => 'services']))->name('services.create');

Route::get('/subscriptions', fn () => view('subscriptions.index', ['active' => 'subscriptions']))->name('subscriptions.index');
Route::get('/subscriptions/create', fn () => view('subscriptions.form', ['active' => 'subscriptions']))->name('subscriptions.create');
EOF

echo "Created: routes/web.php"

# resources/css/app.css
cat > resources/css/app.css << 'EOF'
@import "tailwindcss";

@source '../../vendor/laravel/framework/src/Illuminate/Pagination/resources/views/*.blade.php';
@source '../../storage/framework/views/*.php';
@source '../**/*.blade.php';
@source '../**/*.js';

body, body * {
    font-weight: 600 !important;
}

@theme {
    --font-sans:
        "Inter", ui-sans-serif, system-ui, sans-serif, "Apple Color Emoji",
        "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
    --color-primary: #394149;
    --color-primary-dark: #2d343b;
}

.sidebar-collapsed {
    width: 5rem;
}

.sidebar-collapsed .sidebar-logo {
    display: none;
}

.sidebar-collapsed .sidebar-label {
    display: none;
}

.sidebar-collapsed .px-4.py-4 {
    justify-content: center;
    padding-left: 0;
    padding-right: 0;
    display: flex;
    width: 100%;
}

.sidebar-collapsed #sidebar-toggle {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    margin: 0 auto;
}

.sidebar-collapsed .sidebar-header {
    justify-content: center;
    padding-left: 0;
    padding-right: 0;
}

.sidebar-collapsed nav a,
.sidebar-collapsed .px-4.py-6 a {
    display: flex;
    justify-content: center;
    align-items: center;
    padding-left: 0;
    padding-right: 0;
    gap: 0;
}

.sidebar-collapsed nav a i,
.sidebar-collapsed .px-4.py-6 a i {
    flex-shrink: 0;
}
EOF

echo "Created: resources/css/app.css"

# Done
echo ""

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Copying compiled assets..."

if [ ! -d "$SCRIPT_DIR/public-build" ]; then
    echo "Error: public-build folder not found."
    exit 1
fi

rm -rf public/build
mkdir -p public
cp -r "$SCRIPT_DIR/public-build" public/build

echo "Created: public/build"
echo "Setup completed successfully!"

if [ "$(basename "$SCRIPT_DIR")" = ".erp-training-pnb-views" ]; then
    echo "Cleaning installer..."
    rm -rf "$SCRIPT_DIR"
fi
