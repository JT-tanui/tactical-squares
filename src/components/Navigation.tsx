import { Link } from "react-router-dom";
import { ChessKnight, BookOpen, Target, Play, BarChart2 } from "lucide-react";

const Navigation = () => {
  return (
    <nav className="fixed bottom-0 left-0 w-full bg-chess-primary p-4 md:relative md:bg-transparent">
      <div className="container mx-auto">
        <div className="flex justify-around md:justify-center md:gap-8">
          <NavItem to="/" icon={<ChessKnight />} label="Home" />
          <NavItem to="/learn" icon={<BookOpen />} label="Learn" />
          <NavItem to="/practice" icon={<Target />} label="Practice" />
          <NavItem to="/play" icon={<Play />} label="Play" />
          <NavItem to="/analyze" icon={<BarChart2 />} label="Analyze" />
        </div>
      </div>
    </nav>
  );
};

const NavItem = ({ to, icon, label }: { to: string; icon: React.ReactNode; label: string }) => (
  <Link
    to={to}
    className="flex flex-col items-center text-chess-light hover:text-chess-accent transition-colors duration-200"
  >
    <span className="text-xl mb-1">{icon}</span>
    <span className="text-xs">{label}</span>
  </Link>
);

export default Navigation;