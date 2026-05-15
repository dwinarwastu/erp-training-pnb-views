# ERP Training PNB — Frontend Views

Setup ERP Subscription Service frontend views into your Laravel project.

## Installation

### 1. Open your Laravel project

```bash
cd your-laravel-project
```

### 2. Clone this repository

```bash
git clone https://github.com/dwinarwastu/erp-training-pnb-views.git .erp-training-pnb-views
```

### 3. Run the setup script

#### Linux / macOS / WSL

```bash
chmod +x .erp-training-pnb-views/setup-views.sh

bash .erp-training-pnb-views/setup-views.sh
```

#### Windows (Git Bash)

```bash
bash .erp-training-pnb-views/setup-views.sh
```

### 4. Clear Laravel cache

```bash
php artisan optimize:clear
```

### 5. Start the Laravel server

```bash
php artisan serve
```

## Routes

| Route | Description |
|-------|-------------|
| `/customers` | Customer management |
| `/services` | Service management |
| `/subscriptions` | Subscription management |
