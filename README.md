# ERP Training PNB — Frontend Views

A setup script to instantly scaffold all frontend Blade views for the ERP Subscription Service into your Laravel project.

## Usage

**1. Download the script into your Laravel project root**
```bash
curl -o setup-views.sh https://raw.githubusercontent.com/[username]/erp-training-pnb-views/master/setup-views.sh
```

**2. Run it**
```bash
chmod +x setup-views.sh && ./setup-views.sh
```

**3. Install and build assets**
```bash
npm install && npm run build
```

**4. Start the server**
```bash
php artisan serve
```

## Pages
| Route | Description |
|-------|-------------|
| `/customers` | Customer management |
| `/services` | Service management |
| `/subscriptions` | Subscription management |
