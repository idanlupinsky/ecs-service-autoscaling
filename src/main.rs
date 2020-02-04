use warp::Filter;
use serde::{Deserialize, Serialize};

#[derive(Deserialize, Serialize)]
struct Valuation {
    value: f64,
    score: f64
}

#[tokio::main]
async fn main() {
    println!("Starting warp server");

    let health_check = warp::path("health-check").map(|| "Healthy");
    let valuation = warp::path("valuation").map(|| {
        warp::reply::json(&Valuation { value: 320445.0, score: 0.25 })
    });
    
    let routes = warp::get().and(health_check.or(valuation));
    warp::serve(routes).run(([0, 0, 0, 0], 3030)).await;
}
