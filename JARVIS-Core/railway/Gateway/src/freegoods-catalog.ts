/** Scalable query taxonomy. Expand lazily, never perform millions of network requests. */
export const categories=[
"smartphone","laptop","tablet","desktop computer","camera","lens","drone","headphones","speaker","television","projector","monitor","graphics card","gaming console","video game","smartwatch","luxury watch","jewelry","handbag","sneakers","designer clothing","collectible","trading cards","comic","manga","anime figure","model kit","building blocks","sports equipment","bicycle","outdoor gear","power tools","home appliance","vacuum cleaner","coffee machine","furniture","musical instrument","guitar","keyboard","vinyl record","movie memorabilia","art print","book","board game","perfume","beauty products","kitchenware","car accessories","baby products","pet supplies","office equipment","3d printer","robotics kit","network equipment","storage drive","smart home","travel accessories","gift card","limited edition"
] as const;
export const brands=[
"Apple","Samsung","Sony","Microsoft","Google","Amazon","Nintendo","PlayStation","Xbox","Valve","Steam Deck","Rockstar Games","Netflix","Coca-Cola","Pepsi","Rolex","Omega","Cartier","Patek Philippe","Audemars Piguet","TAG Heuer","Breitling","Tudor","Casio","Seiko","Garmin","Fitbit","DJI","GoPro","Canon","Nikon","Fujifilm","Leica","Panasonic","Bose","Sennheiser","JBL","Bang & Olufsen","Marshall","Sonos","Beats","Dyson","Miele","Bosch","Siemens","DeLonghi","KitchenAid","Nespresso","LEGO","Mattel","Hasbro","Funko","Bandai","One Piece","Pokémon","Dragon Ball","Marvel","DC Comics","Star Wars","Breaking Bad","Harry Potter","Disney","Pixar","Studio Ghibli","Nike","Adidas","Puma","New Balance","ASICS","Jordan","Converse","Vans","The North Face","Patagonia","Arc'teryx","Columbia","Lululemon","Gucci","Louis Vuitton","Prada","Chanel","Dior","Hermès","Burberry","Moncler","Ralph Lauren","Tommy Hilfiger","Calvin Klein","Uniqlo","IKEA","Herman Miller","Logitech","Razer","Corsair","ASUS","Acer","Dell","HP","Lenovo","Alienware","MSI","NVIDIA","AMD","Intel","Raspberry Pi","Anker","Belkin","Ubiquiti","TP-Link","Bambu Lab","Prusa","Fender","Gibson","Yamaha","Roland","Korg","Shure","Audio-Technica","Beyerdynamic","Bowers & Wilkins","Trek","Specialized","Giant","Brompton","Shimano","Oakley","Ray-Ban","Persol","Montblanc","Parker","Lamy","Le Creuset","WMF","Zwilling","Tefal","Braun","Philips","Oral-B","Gillette","L'Oréal","Estée Lauder","Clinique","La Mer","Lancôme","Kiehl's","Nivea","Rituals","Aesop","The Ordinary","Sephora","Ulta","Zara","H&M","Primark","Comet"
] as const;
export const giftPhrases=["free sample","giveaway","gift","free product","kostenlos","gratis","zu verschenken","freebie","échantillon gratuit","cadeau gratuit","muestra gratis","regalo","campione gratuito","omaggio","amostra grátis","brinde","無料サンプル","無料プレゼント","무료 샘플"] as const;
export function normalizedTerms(values:readonly string[],max=100000){const seen=new Set<string>();for(const v of values){const t=v.trim();if(t.length>=2&&t.length<=80)seen.add(t)}return [...seen].slice(0,max)}
export function catalogQueries(extraBrands:string[]=[],extraCategories:string[]=[],extraPhrases:string[]=[]){
 return normalizedTerms([...brands,...categories,...giftPhrases,...extraBrands,...extraCategories,...extraPhrases]);
}
/** Deterministic rotating slice for rate-limited search; no cross-product explosion. */
export function queryBatch(terms:readonly string[],slot:number,batchSize=12){
 const all=normalizedTerms(terms),size=Math.min(Math.max(Math.floor(batchSize)||1,1),48);
 if(!all.length)return[];
 const offset=((Math.floor(slot)*size)%all.length+all.length)%all.length;
 return Array.from({length:Math.min(size,all.length)},(_,i)=>all[(offset+i)%all.length]);
}
