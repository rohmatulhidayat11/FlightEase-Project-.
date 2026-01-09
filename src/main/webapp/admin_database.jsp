<%@page contentType="text/html" pageEncoding="UTF-8"%>

<style>
    /* Style untuk Skema Database */
    .db-card { border: none; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.05); transition: transform 0.2s; overflow: hidden; }
    .db-card:hover { transform: translateY(-5px); }
    .db-header { background: #1e293b; color: white; padding: 12px 20px; display: flex; justify-content: space-between; align-items: center; font-family: 'Consolas', monospace; font-weight: bold; }
    .db-header i { color: #60a5fa; }
    .db-row { display: flex; justify-content: space-between; padding: 10px 20px; border-bottom: 1px solid #f1f5f9; font-size: 0.9rem; }
    .db-row:last-child { border-bottom: none; }
    .col-pk { background: #ffc107; color: #000; padding: 2px 6px; border-radius: 4px; font-size: 0.7rem; font-weight: bold; margin-right: 8px; }
    .col-fk { background: #0dcaf0; color: #000; padding: 2px 6px; border-radius: 4px; font-size: 0.7rem; font-weight: bold; margin-right: 8px; }
    .col-name { font-weight: 600; color: #334155; }
    .col-type { color: #64748b; font-family: 'Consolas', monospace; font-size: 0.85rem; }
</style>

<div class="mb-4 fade-in">
    <h3 class="fw-bold text-dark"><i class="bi bi-database-fill-gear text-primary me-2"></i>Struktur Basis Data</h3>
    <p class="text-muted">Dokumentasi teknis skema database PostgreSQL yang digunakan dalam sistem.</p>
</div>

<h5 class="text-secondary fw-bold text-uppercase mb-3 ps-2 border-start border-4 border-primary">Master Data Tables</h5>
<div class="row g-4 mb-5">
    <div class="col-md-6 col-xl-4">
        <div class="card db-card h-100">
            <div class="db-header"><span>public.users</span> <i class="bi bi-person-badge"></i></div>
            <div class="db-row"><span><span class="col-pk">PK</span><span class="col-name">id</span></span> <span class="col-type">SERIAL</span></div>
            <div class="db-row"><span><span class="col-name">username</span></span> <span class="col-type">VARCHAR(50)</span></div>
            <div class="db-row"><span><span class="col-name">password</span></span> <span class="col-type">VARCHAR(255)</span></div>
            <div class="db-row"><span><span class="col-name">role</span></span> <span class="col-type">VARCHAR(20)</span></div>
            <div class="db-row"><span><span class="col-name">fullname</span></span> <span class="col-type">VARCHAR(100)</span></div>
        </div>
    </div>

    <div class="col-md-6 col-xl-4">
        <div class="card db-card h-100">
            <div class="db-header"><span>public.airports</span> <i class="bi bi-geo-alt-fill"></i></div>
            <div class="db-row"><span><span class="col-pk">PK</span><span class="col-name">id</span></span> <span class="col-type">SERIAL</span></div>
            <div class="db-row"><span><span class="col-name">code</span></span> <span class="col-type">CHAR(3)</span></div>
            <div class="db-row"><span><span class="col-name">name</span></span> <span class="col-type">VARCHAR(100)</span></div>
            <div class="db-row"><span><span class="col-name">city</span></span> <span class="col-type">VARCHAR(100)</span></div>
        </div>
    </div>
</div>

<h5 class="text-secondary fw-bold text-uppercase mb-3 ps-2 border-start border-4 border-success">Transaction Tables</h5>
<div class="row g-4 mb-4">
    <div class="col-md-6 col-xl-4">
        <div class="card db-card h-100">
            <div class="db-header"><span>public.flights</span> <i class="bi bi-airplane-fill"></i></div>
            <div class="db-row"><span><span class="col-pk">PK</span><span class="col-name">id</span></span> <span class="col-type">SERIAL</span></div>
            <div class="db-row"><span><span class="col-name">flight_number</span></span> <span class="col-type">VARCHAR(10)</span></div>
            <div class="db-row"><span><span class="col-fk">FK</span><span class="col-name">origin_id</span></span> <span class="col-type">INT -> airports</span></div>
            <div class="db-row"><span><span class="col-fk">FK</span><span class="col-name">destination_id</span></span> <span class="col-type">INT -> airports</span></div>
            <div class="db-row"><span><span class="col-name">departure_time</span></span> <span class="col-type">TIMESTAMP</span></div>
            <div class="db-row"><span><span class="col-name">price</span></span> <span class="col-type">DECIMAL</span></div>
        </div>
    </div>

    <div class="col-md-6 col-xl-4">
        <div class="card db-card h-100">
            <div class="db-header"><span>public.bookings</span> <i class="bi bi-cart-check-fill"></i></div>
            <div class="db-row"><span><span class="col-pk">PK</span><span class="col-name">id</span></span> <span class="col-type">SERIAL</span></div>
            <div class="db-row"><span><span class="col-fk">FK</span><span class="col-name">user_id</span></span> <span class="col-type">INT -> users</span></div>
            <div class="db-row"><span><span class="col-fk">FK</span><span class="col-name">flight_id</span></span> <span class="col-type">INT -> flights</span></div>
            <div class="db-row"><span><span class="col-name">booking_date</span></span> <span class="col-type">TIMESTAMP</span></div>
            <div class="db-row"><span><span class="col-name">total_price</span></span> <span class="col-type">DECIMAL</span></div>
            <div class="db-row"><span><span class="col-name">status</span></span> <span class="col-type">VARCHAR(20)</span></div>
        </div>
    </div>

    <div class="col-md-6 col-xl-4">
        <div class="card db-card h-100">
            <div class="db-header"><span>public.passengers</span> <i class="bi bi-people-fill"></i></div>
            <div class="db-row"><span><span class="col-pk">PK</span><span class="col-name">id</span></span> <span class="col-type">SERIAL</span></div>
            <div class="db-row"><span><span class="col-fk">FK</span><span class="col-name">booking_id</span></span> <span class="col-type">INT -> bookings</span></div>
            <div class="db-row"><span><span class="col-name">name</span></span> <span class="col-type">VARCHAR(100)</span></div>
            <div class="db-row"><span><span class="col-name">title</span></span> <span class="col-type">VARCHAR(10)</span></div>
        </div>
    </div>
</div>