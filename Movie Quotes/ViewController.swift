//
//  ViewController.swift
//  Movie Quotes
//
//  Created by Mac on 12/05/1443 AH.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var movieList = Movies()
    //array of struct
    var selectedMovies = [Movie]()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
    
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination = segue.destination as! QuotesViewController
        destination.secondSelectedMovies = selectedMovies
    }

}


extension ViewController: UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.movies.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! CustomCollectionViewCell

        
        cell.movieImage.image = movieList.movies[indexPath.item].image
        cell.movieName.text = movieList.movies[indexPath.item].name
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        
        cell?.layer.borderColor = UIColor.systemYellow.cgColor
        cell?.layer.borderWidth = 5
        cell?.layer.cornerRadius = 10
    
        
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        print("cell number \(indexPath.item)")
        
        selectedMovies.append(movieList.movies[indexPath.item])
        
        print("add -- \(selectedMovies)")
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("un select cell number \(indexPath.item)")
       
        
        let cell = collectionView.cellForItem(at: indexPath)

        cell?.layer.borderColor = .none
        cell?.layer.borderWidth = 0
        cell?.layer.cornerRadius = 0
    
    
        for movie in 0..<selectedMovies.count {
            
            if selectedMovies[movie].name == movieList.movies[indexPath.item].name {
                selectedMovies.remove(at: movie)
             
        }

        print("remove-- \(indexPath.item)")
    }

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let w = (collectionView.bounds.width / 3.0) - 100
        let h = w
        
        return CGSize(width: w, height: h)
    }
}

struct Movie{
    
    var name: String
    var image: UIImage
    var quots = [String]()
}

class Movies{
    
    var movies = [Movie]()
    
    init() {
        
        movies.append(Movie(name: "Friends", image: UIImage(named: "friends.png")! , quots: ["Oh. My. God." , "How you doin'?" ] ))
        movies.append(Movie(name: "Bad Moms", image: UIImage(named: "badMoms.png")! , quots: ["I love my babies so much. God, they hate me." , "I had my first kid when I was 20 and I’ve been running late ever since." ] ))
        movies.append(Movie(name: "Spy", image: UIImage(named: "spy.png")! , quots: ["I believe that I can make a difference." , "I am the biggest patriot of my beloved country." ] ))
        movies.append(Movie(name: "You", image: UIImage(named: "you.png")! , quots: ["I had a reason to kill her." , "You can choose your friends but not your family." ] ))
        movies.append(Movie(name: "Cruella", image: UIImage(named: "cruella.png")! , quots: ["I want to make art, Artie. And I want to make trouble. You in?" , "Being a genius is one thing. Raising a genius however, does come with its challenges." ] ))
        movies.append(Movie(name: "Greys Anatomy", image: UIImage(named: "greysAnatomy.png")! , quots: ["Sometimes it's good to be scared. It means you still have something to lose." , "If there's an upside to free-falling, it's the chance you give your friends to catch you." ] ))
        movies.append(Movie(name: "Age Of Youth", image: UIImage(named: "ageOfYouth.png")! , quots: ["I know that it feels like everyone is talking about you. But, that’s not true. People don’t really care. Only you care." , "The one that hurts never knows. Only the one that is hurt remembers." ] ))
        movies.append(Movie(name: "House Of GUCCI", image: UIImage(named: "houseOfGUCCI.png")! , quots: ["It’s time to take out the trash." , "I can assure you, I’m way more fun." ] ))
    }
}
